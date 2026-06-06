use std::borrow::Cow;
use std::env::{self, args, home_dir};
use std::path::PathBuf;

fn main() {
    let mut output = String::with_capacity(40);

    if env::var("SSH_TTY").is_ok() {
        output.push_str("󰖐 ");
    }

    output.push_str(&pwd());

    if let Some(cmd) = args().nth(1) {
        output.push_str(&format!(" {cmd}"));
    }

    println!("{output}");
}

fn pwd() -> Cow<'static, str> {
    let Some(pwd) = env::var_os("PWD") else {
        return "[unknown]".into();
    };

    if let Some(home) = home_dir()
        && home.as_os_str() == pwd
    {
        return "~".into();
    }

    let pwd = PathBuf::from(pwd);
    if let Some(basename) = pwd.file_name().and_then(|s| s.to_str()) {
        basename.to_string().into()
    } else {
        pwd.display().to_string().into()
    }
}
