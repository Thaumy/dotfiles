#!/usr/bin/env rust-script

//! ```cargo
//! [dependencies]
//! libc = "0.2.155"
//! fd-lock = "4.0.2"
//! ```

use std::fs::File;
use std::io::Write;
use std::process::{Command, Stdio};
use std::sync::mpsc::channel;
use std::time::Duration;
use std::{env, thread};

use fd_lock::RwLock;
use libc::SIGTERM;

const LOCK_FILE: &str = "/home/thaumy/cfg/home-manager/sh/wm/wm.lock";

fn new_cmd<const N: usize>(cmd: [&str; N]) -> Command {
    let mut c = Command::new(cmd[0]);
    c.args(&cmd[1..]);
    c
}

fn spawn_cmd<const N: usize>(cmd: [&str; N]) {
    new_cmd(cmd).spawn().unwrap();
}

fn wait_cmd<const N: usize>(cmd: [&str; N]) {
    new_cmd(cmd).status().unwrap();
}

fn main() {
    let mut lock_file = RwLock::new(File::open(LOCK_FILE).unwrap());
    // held the lock
    let _lock = match lock_file.try_write() {
        Ok(guard) => guard,
        Err(_) => return,
    };

    let color_scheme = {
        let stdout = new_cmd(["dconf", "read", "/org/gnome/desktop/interface/color-scheme"])
            .output()
            .unwrap()
            .stdout;
        String::from_utf8(stdout).unwrap().replace('\n', "")
    };
    let is_light_theme = color_scheme == "'light'";
    let color_scheme_icon = if is_light_theme { '󰽢' } else { '󰽤' };

    let power_profie = {
        let stdout = new_cmd(["powerprofilesctl", "get"])
            .output()
            .unwrap()
            .stdout;
        String::from_utf8(stdout).unwrap().replace('\n', "")
    };
    let power_profie_icon = match power_profie.as_str() {
        "power-saver" => '󰂏',
        "balanced" => '󰾅',
        _ => '󰓅',
    };

    let on_disable_kb = new_cmd(["pgrep", "-f", "disable-kb"])
        .status()
        .unwrap()
        .success();
    let kb_icon = if on_disable_kb { '󰌌' } else { '󰌐' };

    let menu = format!(
        "󰓠\n󰹑\n{}\n{}\n󰌾\n󰍃\n{}\n󰒲\n󰜗",
        color_scheme_icon, power_profie_icon, kb_icon
    );

    let args: Vec<String> = env::args().collect();
    let timeout = str::parse(&args[1]).unwrap();

    let selection = {
        let mut rofi = new_cmd([
            "rofi",
            "-dmenu",
            "-select",
            "󰌾",
            "-font",
            "Material Icons 10",
            "-config",
            "/home/thaumy/cfg/rofi/wm-menu.rasi",
        ])
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .spawn()
        .unwrap();

        rofi.stdin
            .as_mut()
            .unwrap()
            .write_all(menu.as_bytes())
            .unwrap();

        let pid = rofi.id();

        let (tx, rx) = channel();

        thread::spawn({
            let tx = tx.clone();
            move || {
                thread::sleep(Duration::from_secs(timeout));
                tx.send(Err(())).unwrap();
            }
        });
        thread::spawn(move || {
            let out = rofi.wait_with_output().unwrap().stdout;
            let sel = String::from_utf8(out).unwrap().chars().next();
            tx.send(Ok(sel)).unwrap();
        });

        match rx.recv().unwrap() {
            Ok(Some(sel)) => sel,
            Ok(None) => return,
            Err(()) => {
                unsafe { libc::kill(pid as _, SIGTERM) };
                return;
            }
        }
    };

    match selection {
        // theme switching
        '󰽢' => {
            wait_cmd([
                "dconf",
                "write",
                "/org/gnome/desktop/interface/color-scheme",
                "'prefer-dark'",
            ]);
            wait_cmd([
                "dconf",
                "write",
                "/org/gnome/desktop/interface/gtk-theme",
                "'WhiteSur-Dark'",
            ]);
        }
        '󰽤' => {
            wait_cmd([
                "dconf",
                "write",
                "/org/gnome/desktop/interface/color-scheme",
                "'light'",
            ]);
            wait_cmd([
                "dconf",
                "write",
                "/org/gnome/desktop/interface/gtk-theme",
                "'WhiteSur-Light'",
            ]);
        }
        // power management
        '󰂏' => wait_cmd(["powerprofilesctl", "set", "balanced"]),
        '󰾅' => wait_cmd(["powerprofilesctl", "set", "performance"]),
        '󰓅' => wait_cmd(["powerprofilesctl", "set", "power-saver"]),
        // disable keyboard
        '󰌌' => wait_cmd(["sudo", "-E", "pkill", "-f", "disable-kb"]),
        '󰌐' => spawn_cmd(["sudo", "-E", "disable-kb"]),
        // night eyes
        '󰓠' => {
            let on_gammastep = new_cmd(["pgrep", "-x", ".gammastep-wrap"])
                .status()
                .unwrap()
                .success();
            if on_gammastep {
                wait_cmd(["pkill", "-x", ".gammastep-wrap"])
            } else {
                spawn_cmd(["gammastep", "-O", "6000"])
            }
        }
        // screenshot
        '󰹑' => spawn_cmd([
            "hyprshot",
            "-m",
            "region",
            "-o",
            format!("{}/Screenshots", env::var("XDG_PICTURES_DIR").unwrap()).as_str(),
        ]),
        // lock screen
        '󰌾' => spawn_cmd([
            "hyprlock",
            "-c",
            if is_light_theme {
                "/home/thaumy/cfg/hypr/hyprlock/light.conf"
            } else {
                "/home/thaumy/cfg/hypr/hyprlock/dark.conf"
            },
        ]),
        // logout
        '󰍃' => spawn_cmd(["hyprctl", "dispatch", "exit"]),
        // sleep
        '󰒲' => spawn_cmd(["systemctl", "suspend"]),
        // hibernate
        '󰜗' => spawn_cmd(["systemctl", "hibernate"]),
        _ => unreachable!(),
    }
}
