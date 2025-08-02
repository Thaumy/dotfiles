use std::process::{Command, Stdio};

pub fn run(args: &[String]) {
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

    let direction = &args[2];

    if direction == "prev" && (workspace_id > 1) {
        Command::new("hyprctl")
            .args(["dispatch", "workspace", "-1"])
            .output()
            .unwrap();
    } else if direction == "next" && (workspace_id < 6) {
        Command::new("hyprctl")
            .args(["dispatch", "workspace", "+1"])
            .output()
            .unwrap();
    }
}
