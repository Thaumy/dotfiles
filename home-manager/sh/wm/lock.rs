#!/usr/bin/env rust-script

//! ```cargo
//! [dependencies]
//! fd-lock = "4.0.2"
//! ```

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

    let color_scheme = {
        let stdout = Command::new("dconf")
            .args(["read", "/org/gnome/desktop/interface/color-scheme"])
            .output()
            .unwrap()
            .stdout;
        String::from_utf8(stdout).unwrap().replace('\n', "")
    };
    let is_light_theme = color_scheme == "'light'";

    let mut cmd = Command::new("hyprlock");

    if is_light_theme {
        cmd.args(["-c", "/home/thaumy/cfg/hypr/hyprlock/light.conf"]);
    } else {
        cmd.args(["-c", "/home/thaumy/cfg/hypr/hyprlock/dark.conf"]);
    }

    cmd.spawn().unwrap();
}
