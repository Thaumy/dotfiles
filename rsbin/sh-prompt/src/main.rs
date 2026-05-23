use std::env::{self, args, home_dir};
use std::io::{Write, stdout};

use git2::{Repository, RepositoryState};
use whoami::{hostname, username};

const RED: &str = "\x1b[31m";
const NORM: &str = "\x1b[0m";
const CYAN: &str = "\x1b[36m";
const YELLOW: &str = "\x1b[33m";
const BR_BLUE: &str = "\x1b[94m";
const BR_YELLOW: &str = "\x1b[93m";

macro_rules! color {
    ($color:expr, $($arg:tt)*) => {
        format!("{}{}{NORM}", $color, format_args!($($arg)*))
    };
}

fn main() {
    let mut prompt = String::with_capacity(128);
    prompt.push_str("┌╴");

    if let Ok(repo) = Repository::open_from_env() {
        if let Some(s) = git_head(&repo) {
            prompt.push_str(&color!(BR_YELLOW, "{s}"));
            prompt.push(' ');
        }
        if let Some(s) = git_state(&repo) {
            prompt.push_str(&color!(YELLOW, "{s}"));
            prompt.push(' ');
        }
    };

    let hostname = hostname().unwrap_or_else(|_| "[unknown hostname]".to_string());
    let username = username().unwrap_or_else(|_| "[unknown username]".to_string());
    prompt.push_str(&color!(BR_BLUE, "{username}@{hostname}"));
    prompt.push(' ');

    let pwd = pwd().unwrap_or_else(|| "[unknown pwd]".to_string());
    prompt.push_str(&color!(CYAN, "{pwd}"));

    if let Some(s) = exit_status() {
        prompt.push(' ');
        prompt.push_str(&color!(RED, "[{s}]"));
    }

    prompt.push_str("\n└╴");
    stdout().write_all(prompt.as_bytes()).unwrap();
}

fn git_head(repo: &Repository) -> Option<String> {
    let head = repo.head().ok()?;
    if let Ok(s) = head.shorthand()
        && s != "HEAD"
    {
        return Some(s.to_string());
    };

    let oid = head.target()?;
    let obj = repo.find_object(oid, None).ok()?;
    let short_oid = obj.short_id().ok()?;
    let short_oid = String::from_utf8(short_oid.to_vec()).ok()?;
    Some(short_oid)
}

fn git_state(repo: &Repository) -> Option<&str> {
    Some(match repo.state() {
        RepositoryState::Clean => return None,
        RepositoryState::Merge => "mg",
        RepositoryState::Revert | RepositoryState::RevertSequence => "rv",
        RepositoryState::CherryPick | RepositoryState::CherryPickSequence => "cp",
        RepositoryState::Bisect => "bs",
        RepositoryState::Rebase
        | RepositoryState::RebaseInteractive
        | RepositoryState::RebaseMerge => "rb",
        RepositoryState::ApplyMailbox | RepositoryState::ApplyMailboxOrRebase => "am",
    })
}

fn pwd() -> Option<String> {
    let home = home_dir()?;
    let home = home.to_str()?;

    let pwd = env::var("PWD").ok()?;

    Some(match pwd.strip_prefix(home) {
        Some("") => "~".to_string(),
        Some(s) if s.starts_with('/') => format!("~{s}"),
        _ => pwd,
    })
}

fn exit_status() -> Option<String> {
    let code = args().nth(1)?;
    match code.parse::<u8>().ok()? {
        0 => None,
        c if c > 128 => Some(format!("128+{}", c - 128)),
        _ => Some(code),
    }
}
