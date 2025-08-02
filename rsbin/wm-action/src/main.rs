use std::env;
use std::fs::File;

use fd_lock::RwLock;

mod apps;
mod lock;
mod menu;
mod switch_ws;
mod win_to_ws;

const LOCK_FILE: &str = "/home/thaumy/cfg/rsbin/wm-action/lock";

pub fn main() {
    let mut lock_file = RwLock::new(File::open(LOCK_FILE).unwrap());
    // Try to hold the lock
    let _lock = match lock_file.try_write() {
        Ok(guard) => guard,
        Err(_) => return,
    };

    let args: Vec<String> = env::args().collect();
    match args[1].as_str() {
        "apps" => apps::run(&args),
        "lock" => lock::run(),
        "menu" => menu::run(&args),
        "switch-ws" => switch_ws::run(&args),
        "win-to-ws" => win_to_ws::run(&args),
        _ => println!("unknown action"),
    }
}
