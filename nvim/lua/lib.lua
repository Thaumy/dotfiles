local ffi = require 'ffi'

ffi.cdef [[
  void case_conv(
    uint8_t* from_ptr,
    size_t from_len,
    uint8_t to_convention,
    uint8_t** to_ptr,
    size_t* to_len,
    void** ptr_to_drop
  );
  void case_conv_drop(void* ptr);

  void shorten_path(
    uint8_t* original_ptr,
    size_t original_len,
    uint8_t** shorten_ptr,
    size_t* shorten_len,
    void** ptr_to_drop
  );
  void shorten_path_drop(void* ptr);

  void* u32_stack_new();
  void u32_stack_push(void* ptr, uint32_t value);
  bool u32_stack_pop(void* ptr, uint32_t* value);
  uint32_t* u32_stack_top(void* ptr);
  void u32_stack_clear(void* ptr);
  size_t u32_stack_len(void* ptr);
  void u32_stack_drop(void* ptr);

  void* visual_block_pre_alloc();
  bool visual_block_select(
    void* pre_alloc,
    uint8_t* line_ptr,
    size_t line_len,
    size_t cursor_col,
    size_t* sel_from,
    size_t* sel_to
  );
]]

LIBNVIMCFG = ffi.load((os.getenv 'HOME') .. '/.config/libnvimcfg.so')
