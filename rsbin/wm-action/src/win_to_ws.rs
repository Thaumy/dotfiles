use std::process::Command;

pub fn run(args: &[String]) {
    let ws_id = &args[2];

    Command::new("hyprctl")
        .args(["dispatch", "movetoworkspace", ws_id])
        .output()
        .unwrap();
}
