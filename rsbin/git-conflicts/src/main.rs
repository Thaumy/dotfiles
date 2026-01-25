use std::collections::HashSet;
use std::error::Error;
use std::ffi::OsStr;
use std::fs::File;
use std::io::{self, BufRead, BufReader};
use std::os::unix::ffi::OsStrExt;
use std::path::Path;

use git2::{IndexEntry, Repository};

fn has_conflict(entry: &IndexEntry) -> bool {
    // https://github.com/libgit2/libgit2/blob/e9cfa20206a6102484df63d4b2bd0114b04675ac/include/git2/index.h#L104
    let stage = (entry.flags & 0x3000) >> 12;
    stage != 0
}

fn conflict_line_numbers(file: &File) -> io::Result<Vec<usize>> {
    let reader = BufReader::new(file);
    let lines = reader.lines();

    let mut line_numbers = vec![];
    for (n, line) in lines.enumerate() {
        if line?.starts_with("<<<<<<< ") {
            line_numbers.push(n + 1);
        }
    }

    Ok(line_numbers)
}

fn main() -> Result<(), Box<dyn Error>> {
    let repo = Repository::open_from_env()?;
    let repo_root = repo.workdir().expect("no repo root");

    let mut conflicts = HashSet::new();
    let index = repo.index()?;

    for it in index.iter().filter(has_conflict) {
        let path = Path::new(OsStr::from_bytes(&it.path));
        let abs_path = repo_root.join(path);
        conflicts.insert(abs_path);
    }

    let mut conflicts: Vec<_> = conflicts.iter().collect();
    conflicts.sort();

    for path in conflicts {
        let file = File::open(path)?;
        for n in conflict_line_numbers(&file)? {
            println!("{}:{}", path.to_string_lossy(), n);
        }
    }

    Ok(())
}
