use std::collections::HashMap;
use std::env;
use std::env::args;
use std::fs::read_to_string;
use std::os::unix::process::CommandExt;
use std::path::Path;
use std::process::Command;

use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
#[serde(untagged)]
enum Ty {
    Vi(String),
    CdVi { cd: String, vi: String },
    Descent(HashMap<String, Ty>),
}

enum Curr {
    Ty(Ty),
    Map(HashMap<String, Ty>),
}

macro_rules! unknown_arg {
    ($arg:expr) => {{
        eprintln!("unknown argument: {}", $arg);
        return;
    }};
}

macro_rules! expect_arg {
    ($keys:expr) => {{
        let keys: Vec<&str> = $keys.map(|it| it.as_str()).collect();
        let keys = keys.join(", ");
        eprintln!("expect argument: {}", keys);
        return;
    }};
}

fn main() {
    let mut args = args().skip(1);

    let home = env::var("HOME").unwrap();
    let cfg = format!("{}/.config/rsbin/edit-config/config.toml", home);
    let cfg = read_to_string(cfg).unwrap();
    let cfg: HashMap<String, Ty> = toml::from_str(&cfg).unwrap();

    let mut curr = Curr::Map(cfg);
    while let Some(arg) = args.next() {
        curr = match curr {
            Curr::Ty(ty) => match ty {
                Ty::Descent(mut map) => match map.remove(&arg) {
                    Some(ty) => Curr::Ty(ty),
                    None => unknown_arg!(arg),
                },
                _ => unknown_arg!(arg),
            },
            Curr::Map(mut map) => match map.remove(&arg) {
                Some(ty) => Curr::Ty(ty),
                None => unknown_arg!(arg),
            },
        };
    }

    let (cd, vi) = match curr {
        Curr::Ty(Ty::Vi(path)) => (None, path),
        Curr::Ty(Ty::CdVi { cd, vi }) => (Some(cd), vi),
        Curr::Ty(Ty::Descent(mut map)) => match map.remove("") {
            Some(Ty::Vi(path)) => (None, path),
            Some(Ty::CdVi { cd, vi }) => (Some(cd), vi),
            _ => expect_arg!(map.keys()),
        },
        Curr::Map(mut map) => match map.remove("") {
            Some(Ty::Vi(path)) => (None, path),
            Some(Ty::CdVi { cd, vi }) => (Some(cd), vi),
            _ => expect_arg!(map.keys()),
        },
    };
    let vi = wave_to_home(&vi);
    let cd = cd.map(|it| wave_to_home(&it)).unwrap_or_else(|| {
        Path::new(&vi)
            .parent()
            .unwrap()
            .to_string_lossy()
            .to_string()
    });

    let err = Command::new("nvim")
        .args(["--cmd", &format!("cd {}", cd), &vi])
        .exec();
    panic!("{:?}", err);
}

fn wave_to_home(path: &str) -> String {
    path.replace("~", &env::var("HOME").unwrap())
}
