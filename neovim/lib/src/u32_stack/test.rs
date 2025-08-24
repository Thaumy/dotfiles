use super::{
    u32_stack_clear, u32_stack_drop, u32_stack_len, u32_stack_new, u32_stack_pop, u32_stack_push,
    u32_stack_top,
};

#[test]
fn test() {
    let ptr = u32_stack_new();
    unsafe { u32_stack_push(ptr, 1) };
    unsafe { u32_stack_push(ptr, 2) };
    unsafe { u32_stack_push(ptr, 3) };

    let len = unsafe { u32_stack_len(ptr) };
    assert_eq!(len, 3);

    let top = unsafe { u32_stack_top(ptr) };
    assert_eq!(unsafe { *top }, 3);

    let mut value = 0;
    assert!(unsafe { u32_stack_pop(ptr, &mut value) });
    assert_eq!(value, 3);

    let mut value = 0;
    assert!(unsafe { u32_stack_pop(ptr, &mut value) });
    assert_eq!(value, 2);

    let mut value = 0;
    assert!(unsafe { u32_stack_pop(ptr, &mut value) });
    assert_eq!(value, 1);

    let len = unsafe { u32_stack_len(ptr) };
    assert_eq!(len, 0);

    let mut value = 0;
    assert!(!unsafe { u32_stack_pop(ptr, &mut value) });
    assert_eq!(value, 0);

    unsafe { u32_stack_push(ptr, 4) };
    unsafe { u32_stack_push(ptr, 5) };
    unsafe { u32_stack_push(ptr, 6) };

    let len = unsafe { u32_stack_len(ptr) };
    assert_eq!(len, 3);

    unsafe { u32_stack_clear(ptr) };
    let len = unsafe { u32_stack_len(ptr) };
    assert_eq!(len, 0);

    unsafe { u32_stack_drop(ptr) };
}
