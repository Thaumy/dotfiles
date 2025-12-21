use super::BOUNDS;
#[cfg(debug_assertions)]
use crate::visual_block::debug::DebugChar;

pub fn find_l_bound(rb_stack: &mut Vec<u8>, line: &[u8], from: usize) -> Option<(usize, usize)> {
    let mut start = from;
    loop {
        rb_stack.clear();

        let mut col = start;
        loop {
            let char = *line.get(col)?;

            for (b_ty, (lb, rb)) in BOUNDS.iter().cloned().enumerate() {
                // from != col: Avoid selecting the original col if it's a bound, e.g.:
                //  |
                // <()>
                // This will be handled by the `find_r_bound`.
                if from != col && char == lb {
                    // Pop the pending right bound.
                    if rb_stack.last().cloned() == Some(rb) {
                        rb_stack.pop();
                    }
                    // return greedily
                    else {
                        #[cfg(debug_assertions)]
                        println!("found-L-bound {}:{}\n", col, char as char);

                        return Some((col, b_ty));
                    }
                } else if char == rb {
                    rb_stack.push(char);
                }
            }

            #[cfg(debug_assertions)]
            {
                let stack: Vec<DebugChar> = rb_stack.iter().map(DebugChar::from).collect();
                println!(
                    "find-L-bound {} -> {}:{} {:?}",
                    start, col, char as char, stack
                );
            }

            if col == 0 {
                break;
            } else {
                col -= 1;
            }
        }

        if start > 0 {
            // If bounds on the left are broken, the stack will
            // prevent us from finding the potential bound, move
            // left and try again to ignore the broken bound.
            start -= 1;
        } else {
            break;
        }
    }

    #[cfg(debug_assertions)]
    {
        let stack: Vec<DebugChar> = rb_stack.iter().map(DebugChar::from).collect();
        println!("failed {:?}", stack);
    }

    None
}

pub fn find_r_bound(lb_stack: &mut Vec<u8>, line: &[u8], from: usize) -> Option<(usize, usize)> {
    let len = line.len();

    let mut start = from;
    while start < len {
        lb_stack.clear();

        let mut col = start;
        while col < len {
            let char = *line.get(col)?;

            for (b_ty, (lb, rb)) in BOUNDS.iter().cloned().enumerate() {
                if from != col && char == rb {
                    if lb_stack.last().cloned() == Some(lb) {
                        lb_stack.pop();
                    } else {
                        #[cfg(debug_assertions)]
                        println!("found-R-bound {}:{}\n", col, char as char);

                        return Some((col, b_ty));
                    }
                } else if char == lb {
                    lb_stack.push(char);
                }
            }

            #[cfg(debug_assertions)]
            {
                let stack: Vec<DebugChar> = lb_stack.iter().map(DebugChar::from).collect();
                println!(
                    "find-R-bound {} -> {}:{} {:?}",
                    start, col, char as char, stack
                );
            }

            col += 1;
        }

        start += 1;
    }

    #[cfg(debug_assertions)]
    {
        let stack: Vec<DebugChar> = lb_stack.iter().map(DebugChar::from).collect();
        println!("failed {:?}", stack);
    }

    None
}
