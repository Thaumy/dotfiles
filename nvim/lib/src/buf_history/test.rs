use super::{
    buf_history_add, buf_history_cursor, buf_history_del, buf_history_invalid, buf_history_new,
    buf_history_redo, buf_history_undo,
};

macro_rules! bh {
    ([$($tail:tt),* $(,)?]) => {{
        let bh = buf_history_new();
        bh!(bh, [$($tail,)+])
    }};

    ($bh:ident, []) => {{
        $bh
    }};
    ($bh:ident, [(u, $cursor:literal), $($tail:tt,)*]) => {{
        let cursor = buf_history_undo($bh);
        assert_eq!(cursor, $cursor);
        bh!($bh, [$($tail,)*])
    }};
    ($bh:ident, [(r, $cursor:literal), $($tail:tt,)*]) => {{
        let cursor = buf_history_redo($bh);
        assert_eq!(cursor, $cursor);
        bh!($bh, [$($tail,)*])
    }};
    ($bh:ident, [(-$buf:literal, $cursor:literal), $($tail:tt,)*]) => {{
        buf_history_del($bh, $buf);
        assert_eq!(buf_history_cursor($bh), $cursor);
        bh!($bh, [$($tail,)*])
    }};
    ($bh:ident, [($buf:literal, $cursor:literal), $($tail:tt,)*]) => {{
        buf_history_add($bh, $buf);
        assert_eq!(buf_history_cursor($bh), $cursor);
        bh!($bh, [$($tail,)*])
    }};
    ($bh:ident, [(!$buf:literal, $cursor:literal), $($tail:tt,)*]) => {{
        buf_history_invalid($bh, $buf);
        assert_eq!(buf_history_cursor($bh), $cursor);
        bh!($bh, [$($tail,)*])
    }};
}

macro_rules! test {
    ($name:ident, $tt:tt) => {
        #[test]
        fn $name() {
            unsafe { bh!($tt) };
        }
    };
}

test!(case1, [(1, 1), (2, 2), (3, 3)]);
test!(case2, [(1, 1), (2, 2), (-2, 1)]);
test!(case3, [(1, 1), (2, 2), (-2, 1), (3, 3)]);
test!(case4, [(1, 1), (2, 2), (u, 1)]);
test!(case5, [(1, 1), (2, 2), (u, 1), (u, 0)]);
test!(case6, [(1, 1), (2, 2), (u, 1), (1, 1)]);
test!(case7, [(1, 1), (2, 2), (u, 1), (r, 2)]);
test!(case8, [(1, 1), (2, 2), (u, 1), (1, 1), (r, 0)]);
test!(
    case9,
    [
        (1, 1),
        (2, 2),
        (-2, 1),
        (3, 3),
        (-3, 1),
        (u, 3),
        (u, 1),
        (u, 2),
        (u, 1),
        (r, 2),
        (r, 1),
        (r, 3),
        (r, 1),
        (r, 0),
    ]
);
test!(case10, [(1, 1), (r, 0)]);
test!(case11, [(1, 1), (u, 0)]);
test!(case12, [(1, 1), (1, 1), (1, 1), (u, 0), (u, 0)]);
test!(case13, [(1, 1), (2, 2), (3, 3), (-3, 2), (-2, 1)]);
test!(case14, [(1, 1), (2, 2), (3, 3), (!1, 3), (u, 2), (u, 0)]);
test!(case15, [(1, 1), (!1, 0), (u, 0)]);
test!(case16, [(1, 1), (-1, 0), (u, 1), (r, 0)]);
test!(case17, [(1, 1), (-1, 0), (2, 2), (u, 0)]);
test!(case18, [(1, 1), (!1, 0), (u, 0)]);
test!(case19, [(u, 0), (u, 0), (1, 1)]);
test!(case20, [(r, 0), (r, 0), (1, 1)]);
test!(case21, [(1, 1), (-1, 0), (1, 1)]);
