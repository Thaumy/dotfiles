use std::borrow::Cow;
use std::env::{current_dir, home_dir};
use std::os::unix::ffi::OsStrExt;
use std::path::{Component, Path, PathBuf};
use std::slice;

mod pathdiff;

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn shorten_path(
    original_ptr: *const u8,
    original_len: usize,
    shorten_ptr: *mut *const u8,
    shorten_len: *mut usize,
    ptr_to_drop: *mut *mut PathBuf,
) {
    let original_bytes = unsafe { slice::from_raw_parts(original_ptr, original_len) };
    let original = unsafe { str::from_utf8_unchecked(original_bytes) };

    if let Some(shorten) = transform(Path::new(original)) {
        match shorten {
            Cow::Borrowed(it) => {
                let bytes = it.as_os_str().as_bytes();
                unsafe { *shorten_len = bytes.len() };
                unsafe { *shorten_ptr = bytes.as_ptr() };
            }
            Cow::Owned(it) => {
                let it = Box::new(it);
                let bytes = it.as_os_str().as_bytes();
                unsafe { *shorten_len = bytes.len() };
                unsafe { *shorten_ptr = bytes.as_ptr() };
                let ptr = Box::into_raw(it);
                unsafe { *ptr_to_drop = ptr };
            }
        };
    }
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn shorten_path_drop(ptr: *mut PathBuf) {
    drop(unsafe { Box::from_raw(ptr) });
}

fn transform<'a>(original: &'a Path) -> Option<Cow<'a, Path>> {
    if original.is_relative() {
        return None;
    }

    if let Ok(cwd) = current_dir() {
        if let Ok(strip_cwd) = original.strip_prefix(&cwd) {
            return Some(strip_cwd.into());
        }

        let relative_to_cwd = pathdiff::diff_paths(original, &cwd).filter(|it| {
            let mut dotdot = 0;
            for it in it.components() {
                if let Component::ParentDir = it {
                    dotdot += 1;
                }
                // at most twice, too many dots is confusing
                if dotdot > 2 {
                    return false;
                }
            }
            true
        });

        let home = home_dir()?;
        let start_from_home = original
            .strip_prefix(home)
            .ok()
            .map(|it| Path::new("~").join(it));

        match (relative_to_cwd, start_from_home) {
            (Some(a), Some(b)) => {
                if a.as_os_str().len() < b.as_os_str().len() {
                    // from home is shorter than from root,
                    // so no need to compare with from root
                    Some(a)
                } else {
                    Some(b.into())
                }
            }
            (Some(it), None) => {
                if it.as_os_str().len() > original.as_os_str().len() {
                    None
                } else {
                    Some(it)
                }
            }
            (None, Some(it)) => Some(it.into()),
            (None, None) => None,
        }
    } else {
        let home = home_dir()?;
        let start_from_home = original
            .strip_prefix(home)
            .ok()
            .map(|it| Path::new("~").join(it))?;
        Some(start_from_home.into())
    }
}
