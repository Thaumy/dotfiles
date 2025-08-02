use std::process::{Command, Stdio};
use std::sync::mpsc::channel;
use std::thread;
use std::time::Duration;

use libc::SIGTERM;

enum Event {
    Timeout,
    Selected,
}

pub fn run(args: &[String]) {
    let timeout = str::parse(&args[2]).unwrap();

    let mut rofi = Command::new("rofi")
        .args([
            "-show",
            "drun",
            "-config",
            "/home/thaumy/cfg/rofi/wm-apps.rasi",
        ])
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
