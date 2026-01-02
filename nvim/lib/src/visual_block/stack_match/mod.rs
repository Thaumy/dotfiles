use crate::visual_block::{BOUNDS, PreAlloc};

pub fn match_bounds(
    pre_alloc: &mut PreAlloc,
    line: &[u8],
    cursor_col: usize,
) -> Option<(usize, usize)> {
    let stack = &mut pre_alloc.col_rb_stack;

    'outer: for (col, c) in line.iter().enumerate() {
        // expected right bound
        if let Some((lb_col, expected_rb)) = stack.last()
            && c == expected_rb
        {
            let (lb_col, rb_col) = (*lb_col, col);

            if lb_col < cursor_col && cursor_col < rb_col {
                // cursor within a bound pair:
                //      |
                // foo(bar)baz
                return Some((lb_col, rb_col));
            } else {
                // cursor is outside a bound pair:
                //  |       |
                // foo(bar)baz
                // or cursor is on the bound:
                //    |   |
                // foo(bar)baz
                stack.pop();
                continue 'outer;
            }
        }

        for (lb, rb) in BOUNDS.iter() {
            if c == lb {
                // left bound, push col and expected rb
                stack.push((col, *rb));
                continue 'outer;
            } else if c == rb {
                // unexpected right bound, broken line
                return None;
            }
        }
    }

    None
}
