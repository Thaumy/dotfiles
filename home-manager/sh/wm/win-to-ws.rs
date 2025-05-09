#!/usr/bin/env rust-script

//! ```cargo
//! [dependencies]
//! fd-lock = "4.0.2"
//! ```

use std::env;
use std::fs::File;
use std::process::Command;

use fd_lock::RwLock;

const LOCK_FILE: &str = "/home/thaumy/cfg/home-manager/sh/wm/wm.lock";

fn main() {
    let mut lock_file = RwLock::new(File::open(LOCK_FILE).unwrap());
    // held the lock
    let _lock = match lock_file.try_write() {
        Ok(guard) => guard,
        Err(_) => return,
    };

    let arg = env::args().nth(1).unwrap();

    Command::new("hyprctl")
        .args(["dispatch", "movetoworkspace", arg.as_str()])
        .output()
        .unwrap();
}
