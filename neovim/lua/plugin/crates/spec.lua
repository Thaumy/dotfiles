return {
  'saecki/crates.nvim',
  dev = true,

  event = { 'BufRead Cargo.toml' },

  config = function()
    require 'plugin.crates.cfg'
  end,
}
