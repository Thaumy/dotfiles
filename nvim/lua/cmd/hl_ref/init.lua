local vim_fn = vim.fn
local vim_api = vim.api
local vim_lsp = vim.lsp

local ns = vim_api.nvim_create_namespace 'hl-ref'

local by_ls = require 'cmd.hl_ref.by_ls'
local by_re = require 'cmd.hl_ref.by_re'
local by_ts = require 'cmd.hl_ref.by_ts'

local debounce = require 'infra.debounce':new()

HL_REF = true

vim_api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'LspProgress' }, {
  callback = function(args)
    if not HL_REF then return end

    if args.event == 'LspProgress' then
      local params = args.data.params
      if params ~= nil then
        local value = params.value
        if value ~= nil and value.kind ~= 'end' then
          return
        end
      else
        return
      end
    end

    debounce:schedule(200, function()
      local buf = vim_api.nvim_get_current_buf()

      if vim_api.nvim_get_option_value('buftype', { buf = buf }) ~= '' then
        return
      end

      vim_api.nvim_buf_clear_namespace(buf, ns, 0, -1)

      if not HL_REF then return end

      local pos_params = vim_lsp.util.make_position_params(0, 'utf-8')
      local changedtick = vim_api.nvim_buf_get_changedtick(buf)

      if by_ls(ns, buf, changedtick, pos_params) then return end

      local cursor_pos = pos_params.position
      local cursor_row = cursor_pos.line
      local cursor_col = cursor_pos.character

      local win = vim_api.nvim_get_current_win()
      local top_row = vim_fn.line('w0', win) - 1
      local bot_row = vim_fn.line('w$', win) - 1

      if
          by_ts(
            ns, buf, changedtick,
            cursor_row, cursor_col,
            top_row, bot_row
          )
      then
        return
      end

      by_re(ns, buf, win, cursor_row, cursor_col, top_row, bot_row)
    end)
  end,
})
