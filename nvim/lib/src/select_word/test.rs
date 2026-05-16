use std::ops::Range;

use super::select_word;

fn new_case(line: &str, cursor: usize, selection: Option<Range<usize>>) {
    let line_ptr = line.as_ptr();
    let line_len = line.len();
    let mut start = 0;
    let mut end = 0;

    let found = unsafe { select_word(line_ptr, line_len, cursor, &mut start, &mut end) };

    if found {
        assert_eq!(Some(start..end), selection)
    } else {
        assert!(selection.is_none())
    }
}

macro_rules! test {
    ($name:ident, $line:expr, $cursor:expr) => {
        #[test]
        fn $name() {
            new_case($line, $cursor, None);
        }
    };
    ($name:ident, $line:expr, $cursor:expr, $expected:expr) => {
        #[test]
        fn $name() {
            new_case($line, $cursor, Some($expected));
        }
    };
}

test!(case1, "hello world", 2, 0..5);
test!(case2, "hello world", 8, 6..11);
test!(case3, "hello", 0, 0..5);
test!(case4, "hello", 4, 0..5);
test!(case5, "hello", 5, 0..5);
test!(case6, "hello world", 5);
test!(case7, "hello  world", 5);
test!(case8, "hello  world", 6);
test!(case9, "\thello\n", 0);
test!(case10, "a b", 1);
test!(case11, "a b", 0, 0..1);
test!(case12, "a b", 2, 2..3);
test!(case13, "x", 0, 0..1);
test!(case14, "hello", 3, 0..5);
test!(case15, "  hello", 3, 2..7);
test!(case16, "hello  ", 2, 0..5);
test!(case17, "hello\tworld", 2, 0..5);
test!(case18, "hello\tworld", 5);
test!(case19, "foo bar baz", 0, 0..3);
test!(case20, "foo bar baz", 5, 4..7);
test!(case21, "foo bar baz", 6, 4..7);
test!(case22, "foo bar baz", 10, 8..11);
test!(case23, " ", 0);
test!(case24, "   ", 1);
test!(case25, "\t ", 0);
test!(case26, "✨✨", 0, 0..6);
test!(case27, "✨✨", 3, 0..6);
test!(case28, "hello✨world", 0, 0..13);
test!(case30, "hello ✨world", 6, 6..14);
test!(case29, "hello ✨ world", 2, 0..5);
test!(case31, "hello ✨ world", 15, 10..15);
test!(case32, "hello ✨ world", 5);
test!(case33, "hello ✨ world", 9);
test!(case34, "main()", 0, 0..4);
