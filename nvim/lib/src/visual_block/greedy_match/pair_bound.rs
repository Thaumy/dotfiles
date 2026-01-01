use crate::visual_block::BOUNDS;
#[cfg(debug_assertions)]
use crate::visual_block::debug::DebugChar;

pub fn pair_l_bound(
    lb_stack: &mut Vec<u8>,
    line: &[u8],
    mut from: usize,
    b_ty: usize,
) -> Option<usize> {
    let len = line.len();
    while from < len {
        lb_stack.clear();

        let char = *line.get(from)?;

        #[cfg(debug_assertions)]
        {
            let stack: Vec<DebugChar> = lb_stack.iter().map(DebugChar::from).collect();
            println!("pair-L-bound {}:{} {:?}", from, char as char, stack);
        }

        if line[from] == BOUNDS[b_ty].1 && lb_stack.is_empty() {
            #[cfg(debug_assertions)]
            println!("paird-L-bound {}:{}\n", from, char as char);
            return Some(from);
        }

        for (lb, _) in BOUNDS.iter().cloned() {
            if lb_stack.last().cloned() == Some(lb) {
                lb_stack.pop(); // Pop the matched left bound.
            } else if char == lb {
                lb_stack.push(char);
            }
        }

        from += 1;
    }

    #[cfg(debug_assertions)]
    {
        let stack: Vec<DebugChar> = lb_stack.iter().map(DebugChar::from).collect();
        println!("failed {:?}", stack);
    }

    None
}

pub fn pair_r_bound(
    rb_stack: &mut Vec<u8>,
    line: &[u8],
    mut from: usize,
    b_ty: usize,
) -> Option<usize> {
    loop {
        rb_stack.clear();

        let char = *line.get(from)?;

        #[cfg(debug_assertions)]
        {
            let stack: Vec<DebugChar> = rb_stack.iter().map(DebugChar::from).collect();
            println!("pair-R-bound {}:{} {:?}", from, char as char, stack);
        }

        if line[from] == BOUNDS[b_ty].0 && rb_stack.is_empty() {
            #[cfg(debug_assertions)]
            println!("paired-R-bound {}:{}\n", from, char as char);
            return Some(from);
        }

        for (_, rb) in BOUNDS.iter().cloned() {
            if rb_stack.last().cloned() == Some(rb) {
                rb_stack.pop();
            } else if char == rb {
                rb_stack.push(char);
            }
        }

        if from == 0 {
            break;
        } else {
            from -= 1;
        }
    }

    #[cfg(debug_assertions)]
    {
        let stack: Vec<DebugChar> = rb_stack.iter().map(DebugChar::from).collect();
        println!("failed {:?}", stack);
    }

    None
}
