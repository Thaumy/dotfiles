use std::ffi::CStr;

#[cfg(debug_assertions)]
mod debug;
mod greedy_match;
mod stack_match;
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

    if let Some((lb_col, rb_col)) = stack_match::match_bounds(pre_alloc, line, cursor_col) {
        (*sel_from, *sel_to) = select(cursor_col, lb_col, rb_col);
        #[cfg(debug_assertions)]
        print_selection(line, *sel_from, *sel_to);
        return true;
    }

    if let Some((lb_col, rb_col)) = greedy_match::match_bounds(pre_alloc, line, cursor_col) {
        (*sel_from, *sel_to) = select(cursor_col, lb_col, rb_col);
        #[cfg(debug_assertions)]
        print_selection(line, *sel_from, *sel_to);
        return true;
    }

    false
}

pub struct PreAlloc {
    col_rb_stack: Vec<(usize, u8)>,
    bound_stack: Vec<u8>,
}

#[unsafe(no_mangle)]
pub extern "C" fn visual_block_pre_alloc() -> *mut PreAlloc {
    let pre_alloc = PreAlloc {
        col_rb_stack: Vec::with_capacity(128),
        bound_stack: Vec::with_capacity(128),
    };
    Box::into_raw(Box::new(pre_alloc))
}

fn select(cursor_col: usize, lb_col: usize, rb_col: usize) -> (usize, usize) {
    // cursor must be within the interval
    #[cfg(debug_assertions)]
    assert!(lb_col <= cursor_col && cursor_col <= rb_col);

    #[cfg(debug_assertions)]
    println!("interval [{}, {}]", lb_col + 1, rb_col - 1);

    if cursor_col - lb_col > rb_col - cursor_col {
        #[cfg(debug_assertions)]
        println!("direction ->");
        // cursor near right bound
        (lb_col + 1, rb_col - 1)
    } else {
        #[cfg(debug_assertions)]
        println!("direction <-");
        // cursor near left bound
        (rb_col - 1, lb_col + 1)
    }
}

#[cfg(debug_assertions)]
fn print_selection(line: &[u8], sel_from: usize, sel_to: usize) {
    let line = String::from_utf8_lossy(line).to_string();
    let lo = sel_to.min(sel_from);
    let hi = sel_to.max(sel_from);
    println!("selection {}", &line[lo..=hi]);
}
