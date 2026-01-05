use std::env::args;
use std::fs::File;
use std::io::Write;
use std::os::unix::process::CommandExt;
use std::process::{Command, Stdio};

const DUMP_PATH: &str = "/tmp/tmux-vis-pane-dump";

fn main() {
    match args().nth(1).as_deref() {
        None => capture_dump(false),
        Some("-a") => capture_dump(true),
        Some("-e") => {}
        _ => panic!("unknown option"),
    };

    let e = Command::new("nvim")
        .args(["+$", "+normal 3|", DUMP_PATH])
        .exec();
    panic!("{:?}", e);
}

fn capture_dump(all: bool) {
    let tmux = Command::new("tmux")
        .args(["capture-pane", "-pS", if all { "-" } else { "-1" }])
        .stdout(Stdio::piped())
        .spawn()
        .unwrap();

    let out = String::from_utf8(tmux.wait_with_output().unwrap().stdout).unwrap();
    let trim = out.trim_end();

    let mut dump = File::create(DUMP_PATH).unwrap();
    dump.write_all(trim.as_bytes()).unwrap();
}
