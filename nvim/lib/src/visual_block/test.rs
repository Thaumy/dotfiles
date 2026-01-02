use std::ffi::CString;

use super::{visual_block_pre_alloc, visual_block_select};

fn new_case(cursor: &str, line: &str, interval: &str) {
    let cursor_col = cursor.find('|').unwrap();

    let interval_l = interval.find('[').unwrap();
    let interval_r = interval.find(']').unwrap();
    let (expect_sel_from, expect_sel_to) = if cursor_col - interval_l > interval_r - cursor_col {
        (interval_l, interval_r)
    } else {
        (interval_r, interval_l)
    };

    let line = CString::new(line).unwrap();
    let line_ptr = line.as_ptr();

    let pre_alloc = visual_block_pre_alloc();
    let mut sel_from = 0;
    let mut sel_to = 0;
    let success =
        unsafe { visual_block_select(pre_alloc, line_ptr, cursor_col, &mut sel_from, &mut sel_to) };
    assert!(success);

    assert_eq!(sel_from, expect_sel_from);
    assert_eq!(sel_to, expect_sel_to);
}

macro_rules! test {
    { $name:ident $cursor:literal $line:literal $interval:literal } => {
        #[test]
        fn $name() {
            new_case($cursor, $line, $interval)
        }
    };
}

test! {
    case1
    "                                 |      "
    "Option<Box<UnsafeCell<((), AtomicPtr)>>>"
    "                       [           ]    "
}

test! {
    case2
    "             |                          "
    "Option<Box<UnsafeCell<((), AtomicPtr)>>>"
    "           [                         ]  "
}

test! {
    case3
    "  |        "
    "(<(), foo>)"
    "  [     ]  "
}

test! {
    case4
    "        |       "
    "<(Vec<()>, i32)>"
    "  [          ]  "
}

test! {
    case5
    "   |        "
    "<(foo, bar>)"
    "  [       ] "
}

test! {
    case6
    "        |   "
    "<(foo, bar>)"
    " [       ]  "
}

test! {
    case7
    "    |         "
    "[ <foo, bar) ]"
    " [          ] "
}

test! {
    case8
    " |        "
  r#"("123456")"#
    " [      ] "
}

test! {
    case9
    "        | "
  r#"("123456")"#
    " [      ] "
}

test! {
    case10
    " |            "
  r#"["123", "abc"]"#
    " [          ] "
}

test! {
    case11
    "            | "
  r#"["123", "abc"]"#
    " [          ] "
}

test! {
    case12
    "  |      "
    "<[>123<]>"
    "  [   ]  "
}

test! {
    case13
    "   |       "
  r#""<[>123<]>""#
    "   [   ]   "
}

test! {
    case14
    "    |    "
  r#"(1234567)"#
    " [     ] "
}

test! {
    case15
    "           |       "
  r#"("123".to_string())"#
    " [               ] "
}
