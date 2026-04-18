local ffi = require 'ffi'

ffi.cdef [[
  void* buf_history_new();
  void buf_history_add(void* bh, uint32_t buf);
  void buf_history_del(void* bh, uint32_t buf);
  uint32_t buf_history_cursor(void* bh);
  uint32_t buf_history_undo(void* bh);
  uint32_t buf_history_redo(void* bh);
  void buf_history_invalid(void* bh, uint32_t buf);
  void buf_history_drop(void* bh);

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
