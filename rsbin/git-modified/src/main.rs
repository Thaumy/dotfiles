use std::mem;

use git2::{DiffFormat, Repository, Status, StatusOptions};

#[derive(Clone, Debug)]
enum State {
    Context {
        lineno: u32,
        delta_before: bool,
        single: bool,
    },
    Delta {
        path: String,
        del_start: Option<u32>,
        add_start: Option<u32>,
        delta: isize,
    },
    Skip,
}

fn main() -> Result<(), git2::Error> {
    let repo = Repository::open_from_env().unwrap();

    let head_tree = repo.head()?.peel_to_tree()?;
    let diff = repo.diff_tree_to_workdir_with_index(Some(&head_tree), None)?;

    let mut state = State::Context {
        lineno: 1,
        delta_before: false,
        single: true,
    };
    diff.print(DiffFormat::Patch, |diff_delta, _, diff_line| {
        match diff_line.origin() {
            '+' | '>' => match &mut state {
                State::Context {
                    delta_before,
                    single,
                    ..
                } => {
                    state = if *delta_before && *single {
                        State::Skip
                    } else {
                        let path = diff_delta
                            .new_file()
                            .path()
                            .or_else(|| diff_delta.old_file().path())
                            .expect("no path")
                            .to_string_lossy();
                        let lineno = diff_line.new_lineno().expect("no line number");
                        State::Delta {
                            path: path.to_string(),
                            del_start: None,
                            add_start: Some(lineno),
                            delta: 1,
                        }
                    }
                }
                State::Delta {
                    path,
                    del_start,
                    add_start,
                    delta,
                } => {
                    state = State::Delta {
                        path: mem::take(path),
                        del_start: *del_start,
                        add_start: add_start
                            .or_else(|| Some(diff_line.new_lineno().expect("no line number"))),
                        delta: *delta + 1,
                    };
                }
                _ => {}
            },
            '-' | '<' => match &mut state {
                State::Context {
                    lineno,
                    delta_before,
                    single,
                } => {
                    state = if *delta_before && *single {
                        State::Skip
                    } else {
                        let path = diff_delta
                            .new_file()
                            .path()
                            .or_else(|| diff_delta.old_file().path())
                            .expect("no path")
                            .to_string_lossy();
                        State::Delta {
                            path: path.to_string(),
                            del_start: Some(*lineno),
                            add_start: None,
                            delta: -1,
                        }
                    }
                }
                State::Delta {
                    path,
                    del_start,
                    add_start,
                    delta,
                } => {
                    state = State::Delta {
                        path: mem::take(path),
                        del_start: *del_start,
                        add_start: *add_start,
                        delta: *delta - 1,
                    }
                }
                _ => {}
            },
            ' ' | '=' => {
                let lineno = diff_line.new_lineno().expect("no line number");
                match &state {
                    State::Delta {
                        path,
                        del_start,
                        add_start,
                        delta,
                    } => {
                        if *delta < 0 {
                            println!("{path}:{}", del_start.expect("no del_start"))
                        } else {
                            println!("{path}:{}", add_start.expect("no add_start"))
                        }

                        state = State::Context {
                            lineno,
                            delta_before: true,
                            single: true,
                        }
                    }
                    State::Context { delta_before, .. } => {
                        state = State::Context {
                            lineno,
                            delta_before: *delta_before,
                            single: false,
                        }
                    }
                    State::Skip => {
                        state = State::Context {
                            lineno,
                            delta_before: true,
                            single: true,
                        }
                    }
                }
            }
            _ => {
                if let State::Delta {
                    path,
                    del_start,
                    add_start,
                    delta,
                } = &state
                {
                    if *delta < 0 {
                        let del_start = del_start.expect("no del_start");
                        if del_start == 1 && add_start.is_none() {
                            println!("{path}")
                        } else {
                            println!("{path}:{del_start}")
                        }
                    } else {
                        println!("{path}:{}", add_start.expect("no add_start"))
                    }
                }

                state = State::Context {
                    lineno: 1,
                    delta_before: false,
                    single: true,
                };
            }
        }

        true
    })?;

    if let State::Delta {
        path,
        del_start,
        add_start,
        delta,
    } = state
    {
        if delta < 0 {
            let del_start = del_start.expect("no del_start");
            if del_start == 1 && add_start.is_none() {
                println!("{path}")
            } else {
                println!("{path}:{del_start}")
            }
        } else {
            println!("{path}:{}", add_start.expect("no add_start"))
        }
    }

    let mut opts = StatusOptions::new();
    opts.include_untracked(true);

    let statuses = repo.statuses(Some(&mut opts))?;

    // list untracked files
    for entry in statuses.iter() {
        let status = entry.status();
        if status.contains(Status::WT_NEW) {
            let path = String::from_utf8_lossy(entry.path_bytes());
            println!("{}", path);
        }
    }

    Ok(())
}
