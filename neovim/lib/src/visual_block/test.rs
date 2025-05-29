use super::visual_block;

#[test]
fn case1() {
    //                        [        |  ]
    // Option<Box<UnsafeCell<((), AtomicPtr)>>>
    let line = c"Option<Box<UnsafeCell<((), AtomicPtr)>>>";
    let mut sel_from = 0;
    let mut sel_to = 0;

    visual_block(line.as_ptr(), 32, &mut sel_from, &mut sel_to);

    assert_eq!(sel_from, 23);
    assert_eq!(sel_to, 35);
}

#[test]
fn case2() {
    //            [  |                      ]
    // Option<Box<UnsafeCell<((), AtomicPtr)>>>
    let line = c"Option<Box<UnsafeCell<((), AtomicPtr)>>>";
    let mut sel_from = 0;
    let mut sel_to = 0;

    visual_block(line.as_ptr(), 14, &mut sel_from, &mut sel_to);

    assert_eq!(sel_from, 37);
    assert_eq!(sel_to, 11);
}

#[test]
fn case3() {
    //   |
    //   [     ]
    // (<(), foo>)
    let line = c"(<(), foo>)";
    let mut sel_from = 0;
    let mut sel_to = 0;

    visual_block(line.as_ptr(), 2, &mut sel_from, &mut sel_to);

    assert_eq!(sel_from, 8);
    assert_eq!(sel_to, 2);
}

#[test]
fn case4() {
    //   [     |    ]
    // <(Vec<()>, i32)>
    let line = c"<(Vec<()>, i32)>";
    let mut sel_from = 0;
    let mut sel_to = 0;

    visual_block(line.as_ptr(), 8, &mut sel_from, &mut sel_to);

    assert_eq!(sel_from, 2);
    assert_eq!(sel_to, 13);
}

#[test]
fn case5() {
    //   [|      ]
    // <(foo, bar>)
    let line = c"<(foo, bar>)";
    let mut sel_from = 0;
    let mut sel_to = 0;

    visual_block(line.as_ptr(), 3, &mut sel_from, &mut sel_to);

    assert_eq!(sel_from, 10);
    assert_eq!(sel_to, 2);
}

#[test]
fn case6() {
    //   [     |]
    // <(foo, bar>)
    let line = c"<(foo, bar>)";
    let mut sel_from = 0;
    let mut sel_to = 0;

    visual_block(line.as_ptr(), 8, &mut sel_from, &mut sel_to);

    assert_eq!(sel_from, 2);
    assert_eq!(sel_to, 10);
}

#[test]
fn case7() {
    //  [  |       ]
    // [ <foo, bar) ]
    let line = c"[ <foo, bar) ]";
    let mut sel_from = 0;
    let mut sel_to = 0;

    visual_block(line.as_ptr(), 4, &mut sel_from, &mut sel_to);

    assert_eq!(sel_from, 12);
    assert_eq!(sel_to, 1);
}
