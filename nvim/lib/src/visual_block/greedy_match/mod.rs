use find_bound::{find_l_bound, find_r_bound};
use pair_bound::{pair_l_bound, pair_r_bound};

use crate::visual_block::PreAlloc;

mod find_bound;
mod pair_bound;

pub fn match_bounds(
    pre_alloc: &mut PreAlloc,
    line: &[u8],
    cursor_col: usize,
) -> Option<(usize, usize)> {
    let len = line.len();

    // Find from the col to establish the correct char stack if
    // the current col is a bound.
    let mut l_from = cursor_col;
    let mut r_from = cursor_col;

    loop {
        let Some((lb_col, lb_ty)) = find_l_bound(&mut pre_alloc.bound_stack, line, l_from) else {
            break None; // No more left bound.
        };
        let Some((rb_col, rb_ty)) = find_r_bound(&mut pre_alloc.bound_stack, line, r_from) else {
            break None; // No more right bound.
        };

        if lb_ty == rb_ty {
            break Some((lb_col, rb_col));
        }

        let lb_pair_col = if rb_col < len {
            pair_l_bound(&mut pre_alloc.bound_stack, line, cursor_col + 1, lb_ty)
        } else {
            None
        };
        let rb_pair_col = if lb_col > 0 {
            pair_r_bound(&mut pre_alloc.bound_stack, line, cursor_col - 1, rb_ty)
        } else {
            None
        };

        match (lb_pair_col, rb_pair_col) {
            (Some(lb_pair_col), Some(rb_pair_col)) => {
                // Select the superset.
                if lb_col < rb_pair_col && rb_col < lb_pair_col {
                    break Some((lb_col, lb_pair_col));
                } else if rb_pair_col < lb_col && lb_pair_col < rb_col {
                    break Some((rb_pair_col, rb_col));
                }

                // Select bounds that is closer to the cursor.
                let d_l = (cursor_col - lb_col).min(lb_pair_col - cursor_col);
                let d_r = (rb_col - cursor_col).min(cursor_col - rb_pair_col);
                if d_l < d_r {
                    break Some((lb_col, lb_pair_col));
                } else {
                    break Some((rb_pair_col, rb_col));
                }
            }
            (Some(lb_pair_col), None) => {
                break Some((lb_col, lb_pair_col));
            }
            (None, Some(rb_pair_col)) => {
                break Some((rb_pair_col, rb_col));
            }
            (None, None) => {
                // No matched bounds found, expand the range to retry, e.g.:
                // <- lb_col   rb_col ->
                //      |        |
                //   '[ <foo, bar) ]'
                if lb_col > 0 && rb_col < len {
                    l_from = lb_col - 1;
                    r_from = rb_col + 1;
                } else {
                    break None;
                }
            }
        }
    }
}
