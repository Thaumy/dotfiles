#!/usr/bin/env rust-script

//! ```cargo
//! [dependencies]
//! fd-lock = "4.0.2"
//! ```

use std::env;
use std::fs::File;
use std::process::{Command, Stdio};

use fd_lock::RwLock;

const LOCK_FILE: &str = "/home/thaumy/cfg/home-manager/sh/wm/wm.lock";

fn main() {
    let mut lock_file = RwLock::new(File::open(LOCK_FILE).unwrap());
    // held the lock
    let _lock = match lock_file.try_write() {
        Ok(guard) => guard,
        Err(_) => return,
    };

    let hyprctl = Command::new("hyprctl")
        .args(["activeworkspace", "-j"])
        .stdout(Stdio::piped())
        .spawn()
        .unwrap();

    let workspace_id = {
        let json = String::from_utf8(hyprctl.wait_with_output().unwrap().stdout).unwrap();
        let id_line = json.lines().nth(1).unwrap();
        let id_chars = id_line.chars().skip(10).take_while(|c| c != &',');
        let id_string: String = id_chars.collect();
        id_string.parse::<u32>().unwrap()
    };

    let arg = env::args().nth(1).unwrap();

    if arg == "prev" && (workspace_id > 1) {
        Command::new("hyprctl")
            .args(["dispatch", "workspace", "-1"])
            .output()
            .unwrap();
    } else if arg == "next" && (workspace_id < 6) {
        Command::new("hyprctl")
            .args(["dispatch", "workspace", "+1"])
            .output()
            .unwrap();
    }
}
