local ffi = require 'ffi'

ffi.cdef [[
  void* visual_block_pre_alloc();
  bool visual_block_select(
    void* pre_alloc,
    int8_t* line,
    size_t cursor_col,
    size_t* sel_from,
    size_t* sel_to
  );

  void* u32_stack_new();
  void u32_stack_push(void* ptr, uint32_t value);
  bool u32_stack_pop(void* ptr, uint32_t* value);
  uint32_t* u32_stack_top(void* ptr);
  void u32_stack_clear(void* ptr);
  size_t u32_stack_len(void* ptr);
  void u32_stack_drop(void* ptr);
]]

LIBNVIMCFG = ffi.load((os.getenv 'HOME') .. '/.config/libnvimcfg.so')
