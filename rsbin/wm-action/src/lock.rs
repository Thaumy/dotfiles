use std::process::Command;

pub fn run() {
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
