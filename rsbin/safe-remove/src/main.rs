use std::env::{self, current_dir};
use std::path::{Path, PathBuf};

use anyhow::{Context, Result, bail};

fn main() {
    match raw() {
        Ok(paths) => {
            if paths.is_empty() {
                println!("Nothing happens.");
                return;
            }
            for path in paths {
                println!("- {}", path.to_str().unwrap_or("- <NON UTF-8 PATH>"));
            }
        }
        Err(e) => {
            eprintln!("{}", e);
            eprintln!("Nothing happens.");
        }
    };
}

fn raw() -> Result<Vec<PathBuf>> {
    let cwd = current_dir()
        .with_context(|| "Failed to get cwd.")?
        .canonicalize()
        .with_context(|| "Failed to canonicalize cwd.")?;

    let paths: Result<Vec<PathBuf>> = env::args()
        .skip(1)
        .map(|mut path_string| {
            if path_string.ends_with('/') {
                path_string.pop();
            }
            let path = Path::new(&path_string);
            let path = if path.is_symlink() {
                path.to_owned()
            } else {
                path.canonicalize()
                    .with_context(|| format!("Failed to canonicalize `{}`.", path_string))?
            };
            if cwd.starts_with(&path) {
                bail!(
                    "`{}` is the parent or cwd, refuse to trash.",
                    path.to_str().unwrap_or("<NON UTF-8 PATH>")
                );
            }
            Ok(path)
        })
        .collect();
    let paths = paths?;

    trash::delete_all(&paths).expect("Failed to trash files!");

    Ok(paths)
}
