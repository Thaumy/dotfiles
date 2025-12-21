use std::ffi::CStr;

use find_bound::{find_l_bound, find_r_bound};
use pair_bound::{pair_l_bound, pair_r_bound};

#[cfg(debug_assertions)]
mod debug;
mod find_bound;
mod pair_bound;
#[cfg(test)]
mod test;

const BOUNDS: [(u8, u8); 7] = [
    (b'"', b'"'),
    (b'\'', b'\''),
    (b'(', b')'),
    (b'`', b'`'),
    (b'[', b']'),
    (b'<', b'>'),
    (b'{', b'}'),
];

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn visual_block_select(
    pre_alloc: *mut PreAlloc,
    line: *const i8,
    cursor_col: usize,
    sel_from: *mut usize,
    sel_to: *mut usize,
) -> bool {
    let pre_alloc = unsafe { &mut *pre_alloc };
    let line = unsafe { CStr::from_ptr(line) }.to_bytes();
    let len = line.len();
    let sel_from = unsafe { &mut *sel_from };
    let sel_to = unsafe { &mut *sel_to };

    #[cfg(debug_assertions)]
    {
        let mut spaces = String::new();
        for _ in 0..cursor_col {
            spaces.push(' ');
        }
        println!("cursor   {}|", spaces);

        println!("haystack {}", String::from_utf8_lossy(line));

        let mut indexes = String::new();
        for i in 0..line.len() {
            indexes.push_str(&(i % 10).to_string());
        }
        println!("index    {}\n", indexes);
    }

    // Find from the col to establish the correct char stack if
    // the current col is a bound.
    let mut l_from = cursor_col;
    let mut r_from = cursor_col;

    loop {
        let Some((lb_col, lb_ty)) = find_l_bound(&mut pre_alloc.bound_stack, line, l_from) else {
            break false; // No more left bound.
        };
        let Some((rb_col, rb_ty)) = find_r_bound(&mut pre_alloc.bound_stack, line, r_from) else {
            break false; // No more right bound.
        };

        macro_rules! debug_selection {
            () => {
                #[cfg(debug_assertions)]
                print_selection(line, *sel_from, *sel_to);
            };
        }

        if lb_ty == rb_ty {
            select(cursor_col, lb_col, rb_col, sel_from, sel_to);
            debug_selection!();
            break true;
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
                    select(cursor_col, lb_col, lb_pair_col, sel_from, sel_to);
                    debug_selection!();
                    break true;
                } else if rb_pair_col < lb_col && lb_pair_col < rb_col {
                    select(cursor_col, rb_pair_col, rb_col, sel_from, sel_to);
                    debug_selection!();
                    break true;
                }

                // Select bounds that is closer to the cursor.
                let d_l = (cursor_col - lb_col).min(lb_pair_col - cursor_col);
                let d_r = (rb_col - cursor_col).min(cursor_col - rb_pair_col);
                if d_l < d_r {
                    select(cursor_col, lb_col, lb_pair_col, sel_from, sel_to);
                    debug_selection!();
                    break true;
                } else {
                    select(cursor_col, rb_pair_col, rb_col, sel_from, sel_to);
                    debug_selection!();
                    break true;
                }
            }
            (Some(lb_pair_col), None) => {
                select(cursor_col, lb_col, lb_pair_col, sel_from, sel_to);
                debug_selection!();
                break true;
            }
            (None, Some(rb_pair_col)) => {
                select(cursor_col, rb_pair_col, rb_col, sel_from, sel_to);
                debug_selection!();
                break true;
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
                    break false;
                }
            }
        }
    }
}

pub struct PreAlloc {
    bound_stack: Vec<u8>,
}

#[unsafe(no_mangle)]
pub extern "C" fn visual_block_pre_alloc() -> *mut PreAlloc {
    let pre_alloc = PreAlloc {
        bound_stack: Vec::with_capacity(128),
    };
    Box::into_raw(Box::new(pre_alloc))
}

fn select(
    cursor_col: usize,
    lb_col: usize,
    rb_col: usize,
    sel_from: &mut usize,
    sel_to: &mut usize,
) {
    // cursor must be within the interval
    #[cfg(debug_assertions)]
    assert!(lb_col <= cursor_col && cursor_col <= rb_col);

    #[cfg(debug_assertions)]
    println!("interval [{}, {}]", lb_col + 1, rb_col - 1);

    if cursor_col - lb_col > rb_col - cursor_col {
        println!("direction ->");
        // cursor near right bound
        *sel_from = lb_col + 1;
        *sel_to = rb_col - 1;
    } else {
        println!("direction <-");
        // cursor near left bound
        *sel_from = rb_col - 1;
        *sel_to = lb_col + 1;
    }
}

#[cfg(debug_assertions)]
fn print_selection(line: &[u8], sel_from: usize, sel_to: usize) {
    let line = String::from_utf8_lossy(line).to_string();
    let lo = sel_to.min(sel_from);
    let hi = sel_to.max(sel_from);
    println!("selection {}", &line[lo..=hi]);
}
