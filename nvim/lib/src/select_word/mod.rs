use core::slice;

#[cfg(test)]
mod test;

pub fn is_word_char(c: char) -> bool {
    // [a-zA-Z0-9_-#] or any other non-whitespace non-ascii char
    c.is_alphanumeric() || matches!(c, '_' | '-' | '#') || (!c.is_ascii() && !c.is_whitespace())
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn select_word(
    line_ptr: *const u8,
    line_len: usize,
    cursor: usize,
    sel_from: &mut usize,
    sel_to: &mut usize,
) -> bool {
    let line = unsafe { slice::from_raw_parts(line_ptr, line_len) };
    let line = unsafe { str::from_utf8_unchecked(line) };

    let mut cursor_chars = line[cursor..].char_indices();
    if let Some((_, c)) = cursor_chars.next()
        && !is_word_char(c)
    {
        return false; // cursor is on non-word character
    };

    let mut right = line.len();
    let right_chars = cursor_chars;
    for (offset, c) in right_chars {
        if !is_word_char(c) {
            right = cursor + offset;
            break;
        }
    }

    let mut left = cursor;
    while left > 0 {
        let new_left = line.floor_char_boundary(left - 1);
        let c = line[new_left..left].chars().next();
        // new_left is always less than left, so there must be a character.
        let c = unsafe { c.unwrap_unchecked() };
        if !is_word_char(c) {
            break;
        }
        left = new_left;
    }

    *sel_from = left;
    *sel_to = right;

    true
}
