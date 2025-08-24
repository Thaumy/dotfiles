#[cfg(test)]
mod test;

use std::ptr;

#[unsafe(no_mangle)]
pub extern "C" fn u32_stack_new() -> *mut Vec<u32> {
    let stack = Vec::<u32>::with_capacity(64);
    Box::into_raw(Box::new(stack))
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn u32_stack_push(ptr: *mut Vec<u32>, value: u32) {
    let stack = unsafe { &mut *ptr };
    stack.push(value);
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn u32_stack_pop(ptr: *mut Vec<u32>, value: *mut u32) -> bool {
    let stack = unsafe { &mut *ptr };
    match stack.pop() {
        Some(it) => {
            unsafe { *value = it };
            true
        }
        None => false,
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn u32_stack_top(ptr: *mut Vec<u32>) -> *const u32 {
    let stack = unsafe { &mut *ptr };
    match stack.last() {
        Some(it) => it as *const u32,
        None => ptr::null(),
    }
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn u32_stack_clear(ptr: *mut Vec<u32>) {
    let stack = unsafe { &mut *ptr };
    stack.clear()
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn u32_stack_len(ptr: *const Vec<u32>) -> usize {
    let stack = unsafe { &*ptr };
    stack.len()
}

#[unsafe(no_mangle)]
pub unsafe extern "C" fn u32_stack_drop(ptr: *mut Vec<u32>) {
    drop(unsafe { Box::from_raw(ptr) });
}
