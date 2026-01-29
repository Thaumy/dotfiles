use std::env::args;
use std::error::Error;
use std::process::Command;

use chrono::{DateTime, FixedOffset};
use git2::{Oid, Repository, Signature};

fn main() -> Result<(), Box<dyn Error>> {
    let mut args = args().skip(1);
    let path = args.next().expect("no path");
    let lineno = args.next().expect("no lineno");

    let blame = Command::new("git")
        .args(["blame", "-p", "-L", &format!("{lineno},{lineno}"), &path])
        .output()?;

    if !blame.status.success() {
        let blame_err = blame.stderr.as_slice();
        return Err(String::from_utf8_lossy(blame_err).trim().into());
    }

    let blame_out = blame.stdout.as_slice();
    let commit_id = blame_out
        .split(|b| *b == b' ')
        .next()
        .map(String::from_utf8_lossy)
        .expect("no first line");

    let oid = Oid::from_str(&commit_id)?;
    if oid.is_zero() {
        println!("not committed yet");
        return Ok(());
    }

    let repo = Repository::open_from_env()?;
    let commit = repo.find_commit(oid)?;

    println!("{}", commit.id());

    let author = commit.author();
    let committer = commit.committer();
    if author == committer {
        println!("{}", fmt_sig(&author));
    } else {
        println!("[A] {}", fmt_sig(&author));
        println!("[C] {}", fmt_sig(&committer));
    }

    let message = String::from_utf8_lossy(commit.message_raw_bytes());
    println!("\n{}", message.trim());

    Ok(())
}

fn fmt_sig(sig: &Signature) -> String {
    let name = String::from_utf8_lossy(sig.name_bytes());
    let email = String::from_utf8_lossy(sig.email_bytes());

    let ts = sig.when();
    let tz = FixedOffset::east_opt(ts.offset_minutes() * 60).expect("invalid timezone");
    let utc_time = DateTime::from_timestamp(ts.seconds(), 0).expect("invalid timestamp");
    let local_time = utc_time.with_timezone(&tz).naive_local();
    let local_time = local_time.format("%y-%m-%d %H:%M").to_string();

    format!("{} <{}> in {} ({})", name, email, local_time, tz)
}
