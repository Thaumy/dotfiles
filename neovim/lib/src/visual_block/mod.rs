#[cfg(test)]
mod test;

use std::ffi::CStr;

const BOUNDS: [(u8, u8); 7] = [
    (b'"', b'"'),
    (b'\'', b'\''),
    (b'(', b')'),
    (b'`', b'`'),
    (b'[', b']'),
    (b'<', b'>'),
    (b'{', b'}'),
];

const DEFAULT_CAP: usize = 16;

fn find_l(line: &[u8], mut from: usize) -> Option<(usize, usize)> {
    let mut stack_r = Vec::with_capacity(DEFAULT_CAP);

    loop {
        let mut col = from;
        let mut moved = false;

        loop {
            let c = *line.get(col)?;

            for (ty, (l, r)) in BOUNDS.iter().cloned().enumerate() {
                if moved && c == l {
                    // is left bound and no more pending right bound
                    if stack_r.is_empty() {
                        // return left bound type
                        return Some((col, ty));
                    } else if stack_r.last().cloned() == Some(r) {
                        // pop matched right bound
                        stack_r.pop();
                    }
                } else if c == r {
                    stack_r.push(c);
                }
            }

            if col == 0 {
                break;
            } else {
                col -= 1;
                moved = true;
            }
        }

        if from == 0 {
            break;
        } else {
            // if bounds on the left are broken, the stack will
            // prevent us from finding the potential bound, move
            // left and try again to ignore the broken bound
            stack_r.clear();
            from -= 1;
        }
    }

    None
}

fn find_l_pair(line: &[u8], mut col: usize, ty: usize) -> Option<usize> {
    let max = line.len();
    while col < max {
        if line[col] == BOUNDS[ty].1 {
            return Some(col);
        }
        col += 1;
    }
    None
}

fn find_r(line: &[u8], mut from: usize) -> Option<(usize, usize)> {
    let max = line.len();
    let mut stack_l = Vec::with_capacity(DEFAULT_CAP);

    while from < max {
        let mut col = from;
        let mut moved = false;

        while col < max {
            let c = *line.get(col)?;

            for (ty, (l, r)) in BOUNDS.iter().cloned().enumerate() {
                if moved && c == r {
                    // is right bound and no more pending left bound
                    if stack_l.is_empty() {
                        // return right bound type
                        return Some((col, ty));
                    } else if stack_l.last().cloned() == Some(l) {
                        // pop matched left bound
                        stack_l.pop();
                    }
                } else if c == l {
                    stack_l.push(c);
                }
            }

            col += 1;
            moved = true;
        }

        // if bounds on the left are broken, the stack will
        // prevent us from finding the potential bound, move
        // right and try again to ignore the broken bound
        stack_l.clear();
        from += 1;
    }

    None
}

fn find_r_pair(line: &[u8], mut col: usize, ty: usize) -> Option<usize> {
    loop {
        if line[col] == BOUNDS[ty].1 {
            return Some(col);
        }
        if col == 0 {
            break;
        } else {
            col -= 1;
        }
    }
    None
}

fn select(col: usize, col_l: usize, col_r: usize, sel_from: &mut u32, sel_to: &mut u32) {
    let col = col as u32;
    let col_l = col_l as u32;
    let col_r = col_r as u32;

    if col - col_l > col_r - col {
        *sel_from = col_l + 1;
        *sel_to = col_r - 1;
    } else {
        *sel_from = col_r - 1;
        *sel_to = col_l + 1;
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn visual_block(
    line: *const i8,
    col: u32,
    sel_from: &mut u32,
    sel_to: &mut u32,
) -> bool {
    let col = col as usize;
    let line = unsafe { CStr::from_ptr(line) }.to_bytes();

    let mut from_col_l = col;
    let mut from_col_r = col;

    loop {
        // search from `col` and `moved` above handles the
        // situation when bound is under the cursor
        //            cursor               cursor
        //              |                    |
        // examples: '(<(), foo>)', '<(Vec<()>, i32)>'
        let Some((col_l, ty_l)) = find_l(line, from_col_l) else {
            break false; // no more left bound
        };
        let Some((col_r, ty_r)) = find_r(line, from_col_r) else {
            break false; // no more right bound
        };

        if ty_l == ty_r {
            select(col, col_l, col_r, sel_from, sel_to);
            break true;
        }

        // handle broken bounds, like '<(foo, bar>)'

        let col_l_pair = find_l_pair(line, col_r + 1, ty_l);
        let col_r_pair = find_r_pair(line, col_l - 1, ty_r);

        match (col_l_pair, col_r_pair) {
            (Some(col_l_pair), Some(col_r_pair)) => {
                let d_l = (col - col_l).min(col_l_pair - col);
                let d_r = (col_r - col).min(col - col_r_pair);
                // select the pair close to the cursor
                if d_l < d_r {
                    select(col, col_l, col_l_pair, sel_from, sel_to);
                    break true;
                } else {
                    select(col, col_r_pair, col_r, sel_from, sel_to);
                    break true;
                }
            }
            (Some(col_l_pair), None) => {
                select(col, col_l, col_l_pair, sel_from, sel_to);
                break true;
            }
            (None, Some(col_r_pair)) => {
                select(col, col_r_pair, col_r, sel_from, sel_to);
                break true;
            }
            (None, None) => {
                // no matched pair found, try to search next valid pair
                //               col_l    col_r
                //                 |        |
                // for example: '[ <foo, bar) ]'
                from_col_l = col_l - 1;
                from_col_r = col_r + 1;
            }
        }
    }
}
