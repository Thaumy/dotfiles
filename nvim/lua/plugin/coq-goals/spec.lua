return {
  'Thaumy/coq-goals.nvim',
  dev = true,

  ft = 'coq',

  config = function()
    require 'coq-goals'.setup {}
  end,
}
