#[cfg(test)]
mod test;

pub struct BufHistory {
    history: Vec<i32>,
    cursor: usize,
}

#[unsafe(no_mangle)]
pub extern "C" fn buf_history_new() -> *mut BufHistory {
    let bh = BufHistory {
        history: Vec::with_capacity(128),
        cursor: 0,
    };
    Box::into_raw(Box::new(bh))
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn buf_history_add(bh: *mut BufHistory, buf: u32) {
    let bh = unsafe { &mut *bh };
    let history = &mut bh.history;
    let cursor = bh.cursor;

    // dedup
    if history.last().cloned().unwrap_or_default() == buf as i32 {
        return;
    }

    if cursor == history.len() {
        history.push(buf as i32);
    } else {
        // can only be: cursor < history.len()
        history.truncate(cursor);
        history.push(buf as i32);
    }

    bh.cursor += 1;
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn buf_history_del(bh: *mut BufHistory, buf: u32) {
    let bh = unsafe { &mut *bh };
    let history = &mut bh.history;
    let cursor = bh.cursor;

    if cursor == history.len() {
        history.push(-(buf as i32));
    } else {
        // can only be: cursor < history.len()
        history.truncate(cursor);
        history.push(-(buf as i32));
    }

    bh.cursor += 1;
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn buf_history_cursor(bh: *mut BufHistory) -> u32 {
    let bh = unsafe { &mut *bh };
    let mut cursor = bh.cursor;
    let mut pending = 0_usize;

    loop {
        if cursor == 0 {
            return 0;
        }

        let b = bh.history[cursor - 1];
        if b > 0 {
            if pending == 0 {
                return b as u32;
            } else {
                pending -= 1;
            }
        } else {
            pending += 1;
        }

        cursor -= 1;
    }
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn buf_history_undo(bh: *mut BufHistory) -> u32 {
    let bh = unsafe { &mut *bh };

    if bh.cursor < 2 {
        return 0;
    }

    bh.cursor -= 1;
    unsafe { buf_history_cursor(bh) }
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn buf_history_redo(bh: *mut BufHistory) -> u32 {
    let bh = unsafe { &mut *bh };
    let cursor = bh.cursor;

    if cursor == bh.history.len() {
        return 0;
    }

    bh.cursor += 1;
    unsafe { buf_history_cursor(bh) }
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn buf_history_invalid(bh: *mut BufHistory, buf: u32) {
    let bh = unsafe { &mut *bh };
    let cursor = bh.cursor;

    let mut i = 0;
    let mut before_cursor = 0;
    bh.history.retain(|b| {
        let remove = b.unsigned_abs() == buf;
        if remove && i < cursor {
            before_cursor += 1;
        }
        i += 1;
        !remove
    });

    bh.cursor -= before_cursor;
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn buf_history_drop(bh: *mut BufHistory) {
    drop(unsafe { Box::from_raw(bh) });
}
