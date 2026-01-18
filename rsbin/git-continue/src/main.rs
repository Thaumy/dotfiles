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
            println!("󰜴 merge --continue");
            Command::new("git").args(["merge", "--continue"]).exec()
        }
        RepositoryState::Revert | RepositoryState::RevertSequence => {
            println!("󰜴 revert --continue");
            Command::new("git").args(["revert", "--continue"]).exec()
        }
        RepositoryState::CherryPick | RepositoryState::CherryPickSequence => {
            println!("󰜴 cherry-pick --continue");
            Command::new("git")
                .args(["cherry-pick", "--continue"])
                .exec()
        }
        RepositoryState::Bisect => {
            println!("not applicable to bisect, do nothing.");
            return;
        }
        RepositoryState::Rebase
        | RepositoryState::RebaseInteractive
        | RepositoryState::RebaseMerge => {
            println!("󰜴 rebase --continue");
            Command::new("git").args(["rebase", "--continue"]).exec()
        }
        RepositoryState::ApplyMailbox | RepositoryState::ApplyMailboxOrRebase => {
            println!("󰜴 am --continue");
            Command::new("git").args(["am", "--continue"]).exec()
        }
    };

    println!("exec failed: {:?}", error);
}
