#!/usr/bin/env rust-script

//! ```cargo
//! [dependencies]
//! libc = "0.2.155"
//! fd-lock = "4.0.2"
//! ```

use std::{
    env,
    fs::File,
    process::{Command, Stdio},
    sync::mpsc::channel,
    thread,
    time::Duration,
};

use fd_lock::RwLock;
use libc::SIGTERM;

const LOCK_FILE: &str = "/home/thaumy/cfg/home-manager/sh/wm/wm.lock";

enum Event {
    Timeout,
    Selected,
}

fn main() {
    let mut lock_file = RwLock::new(File::open(LOCK_FILE).unwrap());
    // held the lock
    let _lock = match lock_file.try_write() {
        Ok(guard) => guard,
        Err(_) => return,
    };

    let args: Vec<String> = env::args().collect();
    let timeout = str::parse(&args[1]).unwrap();

    let mut rofi = Command::new("rofi")
        .args(["-show", "drun", "-config", "/home/thaumy/cfg/rofi/wm-apps.rasi"])
        .stdin(Stdio::null())
        .stdout(Stdio::null())
        .spawn()
        .unwrap();

    let pid = rofi.id();

    let (tx, rx) = channel();

    thread::spawn({
        let tx = tx.clone();
        move || {
            thread::sleep(Duration::from_secs(timeout));
            tx.send(Event::Timeout).unwrap();
        }
    });
    thread::spawn(move || {
        rofi.wait().unwrap();
        tx.send(Event::Selected).unwrap();
    });

    match rx.recv().unwrap() {
        Event::Timeout => unsafe {
            libc::kill(pid as _, SIGTERM);
        },
        Event::Selected => (),
    }
}
