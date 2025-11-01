use std::env;
use std::fs::create_dir_all;
use std::path::Path;
use std::process::Command;

use chrono::Local;

fn main() {
    let xdg_pictures_dir = env::var("XDG_PICTURES_DIR").unwrap();
    let screenshots_dir = format!("{}/Screenshots", xdg_pictures_dir);
    let path = Path::new(&screenshots_dir);
    if !path.exists() {
        create_dir_all(path).unwrap()
    }

    let now = Local::now();
    let save_to = format!(
        "{}/{}",
        screenshots_dir,
        now.format("%y-%m-%d_%H:%M:%S_%3f.png")
    );

    Command::new("grim")
        .arg(&save_to)
        .spawn()
        .unwrap()
        .wait()
        .unwrap();
    Command::new("notify-send")
        .args([
            "-i",
            &save_to,
            "Screenshot saved",
            &now.format("%H:%M:%S").to_string(),
        ])
        .spawn()
        .unwrap()
        .wait()
        .unwrap();
}
