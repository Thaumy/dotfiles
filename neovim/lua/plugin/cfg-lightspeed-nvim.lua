local vim = vim
local map = vim.api.nvim_set_keymap

local function setup()
  require "lightspeed".setup {
    jump_to_unique_chars = false,
    safe_labels = {}
  }

  -- remap
  map("n", "f", "<Plug>Lightspeed_omni_s", {})

  -- unmap default lightspeed keymaps
  map("", "F", "F", {})
  map("", "s", "s", {})
  map("", "S", "S", {})
  map("", "t", "t", {})
  map("", "T", "T", {})
  map("", "z", "z", {})
  map("", "Z", "Z", {})
  map("", "x", "x", {})
  map("", "X", "X", {})
  map("", "gs", "", {})
  map("", "gS", "", {})
  map("", ",", ",", {})
  map("", ";", ";", {})
end

return setup()
