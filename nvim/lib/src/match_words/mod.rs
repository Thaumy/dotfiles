#[cfg(test)]
mod test;

use core::slice;

use crate::select_word::is_word_char;

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn match_words_pre_alloc() -> *mut Vec<[usize; 2]> {
    Box::into_raw(Box::new(Vec::with_capacity(128)))
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn match_words(
    pre_alloc: *mut Vec<[usize; 2]>,
    line_ptr: *const u8,
    line_len: usize,
    word_ptr: *const u8,
    word_len: usize,
    matches_ptr: *mut *const usize,
) -> usize {
    let matches = unsafe { &mut *pre_alloc };
    matches.clear();

    let line = unsafe { slice::from_raw_parts(line_ptr, line_len) };
    let line = unsafe { str::from_utf8_unchecked(line) };

    let word = unsafe { slice::from_raw_parts(word_ptr, word_len) };
    let word = unsafe { str::from_utf8_unchecked(word) };

    for (cursor, word) in line.match_indices(word) {
        let word_end = cursor + word.len();

        if let Some(c) = line[word_end..].chars().next()
            && is_word_char(c)
        {
            continue; // have a word character right
        }

        if cursor > 0 {
            let left = line.floor_char_boundary(cursor - 1);
            let c = line[left..cursor].chars().next();
            // left is always less than cursor, so there must be a character.
            let c = unsafe { c.unwrap_unchecked() };
            if is_word_char(c) {
                continue; // have a word character left
            }
        }

        matches.push([cursor, word_end]);
    }

    unsafe { *matches_ptr = matches.as_ptr() as *const usize };
    matches.len() * 2
}
