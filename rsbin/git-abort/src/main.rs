use std::os::unix::process::CommandExt;
use std::process::Command;

use git2::{Repository, RepositoryState};

fn main() {
    let repo = Repository::open_from_env().unwrap();

    let error = match repo.state() {
        RepositoryState::Clean => {
            println!("already clean, do nothing.");
            return;
        }
        RepositoryState::Merge => {
            println!("󰜴 merge --abort");
            Command::new("git").args(["merge", "--abort"]).exec()
        }
        RepositoryState::Revert | RepositoryState::RevertSequence => {
            println!("󰜴 revert --abort");
            Command::new("git").args(["revert", "--abort"]).exec()
        }
        RepositoryState::CherryPick | RepositoryState::CherryPickSequence => {
            println!("󰜴 cherry-pick --abort");
            Command::new("git").args(["cherry-pick", "--abort"]).exec()
        }
        RepositoryState::Bisect => {
            println!("󰜴 bisect reset");
            Command::new("git").args(["bisect", "reset"]).exec()
        }
        RepositoryState::Rebase
        | RepositoryState::RebaseInteractive
        | RepositoryState::RebaseMerge => {
            println!("󰜴 rebase --abort");
            Command::new("git").args(["rebase", "--abort"]).exec()
        }
        RepositoryState::ApplyMailbox | RepositoryState::ApplyMailboxOrRebase => {
            println!("󰜴 am --abort");
            Command::new("git").args(["am", "--abort"]).exec()
        }
    };

    println!("exec failed: {:?}", error);
}
