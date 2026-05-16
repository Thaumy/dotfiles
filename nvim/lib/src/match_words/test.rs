use std::ptr;

use super::{match_words, match_words_pre_alloc};

fn new_case(line: &str, word: &str, expected: &[[usize; 2]]) {
    let line_ptr = line.as_ptr();
    let line_len = line.len();

    let word_ptr = word.as_ptr();
    let word_len = word.len();
    let mut matches = ptr::null();

    let pre_alloc = unsafe { match_words_pre_alloc() };
    let matches_len = unsafe {
        match_words(
            pre_alloc,
            line_ptr,
            line_len,
            word_ptr,
            word_len,
            &mut matches,
        )
    };

    assert_eq!(matches_len, expected.len() * 2);

    let expected = expected.as_ptr() as *const usize;
    for i in 0..matches_len {
        let m = unsafe { *matches.wrapping_add(i) };
        let e = unsafe { *expected.wrapping_add(i) };
        assert_eq!(m, e)
    }
}

macro_rules! test {
    ($name:ident, $line:expr, $cursor:expr, $expected:expr) => {
        #[test]
        fn $name() {
            new_case($line, $cursor, &$expected);
        }
    };
}

test!(case1, "foofoofoo", "foo", []);
test!(case2, "foo foo foo", "foo", [[0, 3], [4, 7], [8, 11]]);
test!(case3, "hello world", "foo", []);
test!(case4, "fooz fooz fooz", "foo", []);
test!(case5, "a b a c a", "a", [[0, 1], [4, 5], [8, 9]]);
test!(case6, "✨✨", "✨", []);
test!(case7, "✨✨", "✨✨", [[0, 6]]);
test!(case8, "wow✨✨", "✨✨", []);
