local notify = require 'notify'

local static_in_fade_out = {
  function(state)
    local next_height = state.message.height + 1
    local next_row = require('notify.stages.util').available_slot(state.open_windows, next_height, "top_down")
    if not next_row then
      return nil
    end
    return {
      relative = 'editor',
      anchor = 'NE',
      width = state.message.width,
      height = state.message.height,
      col = vim.opt.columns:get(),
      row = next_row,
      border = 'solid',
      style = 'minimal',
      opacity = 100,
    }
  end,
  function()
    return {
      col = { vim.opt.columns:get() },
      time = true,
    }
  end,
  function()
    return {
      opacity = {
        0,
        frequency = 4,
        complete = function(cur_opacity)
          return cur_opacity <= 4
        end,
      },
      col = { vim.opt.columns:get() },
    }
  end,
}

notify.setup {
  background_colour = 'NotifyBackground',
  fps = 100,
  icons = {},
  level = 2,
  minimum_width = 0,
  render = 'wrapped-compact',
  stages = static_in_fade_out,
  timeout = 3000,
  top_down = true
}
