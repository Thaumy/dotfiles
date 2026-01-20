use core::slice;

use heck::{
    ToKebabCase, ToLowerCamelCase, ToShoutyKebabCase, ToShoutySnakeCase, ToSnakeCase, ToTitleCase,
    ToTrainCase, ToUpperCamelCase,
};

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn case_conv(
    from_ptr: *const u8,
    from_len: usize,
    to_convention: u8,
    to_ptr: *mut *const u8,
    to_len: *mut usize,
    ptr_to_drop: *mut *mut String,
) {
    let from_bytes = unsafe { slice::from_raw_parts(from_ptr, from_len) };
    let from = unsafe { str::from_utf8_unchecked(from_bytes) };

    let to = Box::new(match to_convention {
        0 => from.to_snake_case(),        // s
        1 => from.to_shouty_snake_case(), // us
        2 => from.to_kebab_case(),        // k
        3 => from.to_shouty_kebab_case(), // uk
        4 => from.to_upper_camel_case(),  // uc
        5 => from.to_lower_camel_case(),  // lc
        6 => from.to_title_case(),        // ti
        7 => from.to_train_case(),        // tr
        _ => return,
    });

    unsafe { *to_ptr = to.as_ptr() };
    unsafe { *to_len = to.len() };
    let ptr = Box::into_raw(to);
    unsafe { *ptr_to_drop = ptr };
}

#[expect(clippy::missing_safety_doc)]
#[unsafe(no_mangle)]
pub unsafe extern "C" fn case_conv_drop(ptr: *mut String) {
    drop(unsafe { Box::from_raw(ptr) });
}
