use std::env::{args, set_current_dir};
use std::os::unix::process::CommandExt;
use std::path::Path;
use std::process::Command;

const ENTRYPOINTS: [&str; 6] = [
    "src/lib.rs",
    "src/main.rs",
    "README.md",
    "README",
    "main.c",
    "flake.nix",
];

fn main() {
    if let Some(cd) = args().skip(1).next() {
        if let Err(e) = set_current_dir(&cd) {
            eprintln!("failed to switch working dir: {}", e);
            return;
        }
    };
    for path in ENTRYPOINTS {
        let path = Path::new(path);
        if path.exists() {
            let _ = Command::new("nvim").arg(path.as_os_str()).exec();
        }
    }
    eprintln!("unknown entrypoint");
}
