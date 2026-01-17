use std::borrow::Cow;
use std::path::{Component, Path, PathBuf};

/// A COW-optimized version of `pathdiff::diff_paths`.
/// See: https://github.com/Manishearth/pathdiff/blob/bf1ea6a5e528f6f244b93f533bf02229fd9ec45e/src/lib.rs#L43
pub fn diff_paths<'a>(path: &'a Path, base: &Path) -> Option<Cow<'a, Path>> {
    if path.is_absolute() != base.is_absolute() {
        return if path.is_absolute() {
            Some(path.into())
        } else {
            None
        };
    }

    let mut ita = path.components().peekable();
    let mut itb = base.components().peekable();

    // ./foo and foo are the same
    if let Some(Component::CurDir) = ita.peek() {
        ita.next();
    }
    if let Some(Component::CurDir) = itb.peek() {
        itb.next();
    }

    let mut buf = PathBuf::new();

    loop {
        match (ita.next(), itb.next()) {
            (None, None) => break,
            (Some(a), None) => {
                buf.push(a);
                buf.extend(ita);
                break;
            }
            (None, _) => buf.push(Component::ParentDir),
            (Some(a), Some(b)) if buf.as_os_str().is_empty() && a == b => (),
            (Some(a), Some(Component::CurDir)) => buf.push(a),
            (Some(_), Some(Component::ParentDir)) => return None,
            (Some(a), Some(_)) => {
                buf.push(Component::ParentDir);
                for _ in itb {
                    buf.push(Component::ParentDir);
                }
                buf.push(a);
                buf.extend(ita);
                break;
            }
        }
    }

    Some(buf.into())
}

#[cfg(test)]
mod tests {
    use std::path::Path;

    use super::diff_paths;

    #[test]
    fn test_subset() {
        check("foo", "fo", Some("../foo"));
        check("fo", "foo", Some("../fo"));
    }

    #[test]
    fn test_empty() {
        check("", "", Some(""));
        check("foo", "", Some("foo"));
        check("", "foo", Some(".."));
    }

    #[test]
    fn test_relative() {
        check("../foo", "../bar", Some("../foo"));
        check("../foo", "../foo/bar/baz", Some("../.."));
        check("../foo/bar/baz", "../foo", Some("bar/baz"));
        check("../foo", "bar", Some("../../foo"));
        check("foo", "../bar", None);

        check("foo/bar/baz", "foo", Some("bar/baz"));
        check("foo/bar/baz", "foo/bar", Some("baz"));
        check("foo/bar/baz", "foo/bar/baz", Some(""));
        check("foo/bar/baz", "foo/bar/baz/", Some(""));

        check("foo/bar/baz/", "foo", Some("bar/baz"));
        check("foo/bar/baz/", "foo/bar", Some("baz"));
        check("foo/bar/baz/", "foo/bar/baz", Some(""));
        check("foo/bar/baz/", "foo/bar/baz/", Some(""));

        check("foo/bar/baz", "foo/", Some("bar/baz"));
        check("foo/bar/baz", "foo/bar/", Some("baz"));
        check("foo/bar/baz", "foo/bar/baz", Some(""));
    }

    #[test]
    fn test_current_directory() {
        check(".", "foo", Some("../."));
        check("foo", ".", Some("foo"));
        check("/foo", "/.", Some("foo"));

        check("./foo/bar/baz", "foo", Some("bar/baz"));
        check("foo/bar/baz", "./foo", Some("bar/baz"));
        check("./foo/bar/baz", "./foo", Some("bar/baz"));
    }

    fn check(path: &str, base: &str, expected: Option<&str>) {
        let path = Path::new(path);
        let base = Path::new(base);
        let expected = expected.map(|it| Path::new(it).into());
        assert_eq!(diff_paths(path, base), expected);
    }
}
