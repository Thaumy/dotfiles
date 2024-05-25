local Popup = require 'nui.popup'
local Layout = require 'nui.layout'
local TsLayout = require 'telescope.pickers.layout'

local prompt_opt = {
  enter = true,
  border = {
    style = {
      top_left = '├',
      top = '─',
      top_right = '┤',
      left = '│',
      right = '│',
      bottom_left = '└',
      bottom = '─',
      bottom_right = '┘',
    },
    text = { top = '' },
  },
  win_options = { winhighlight = 'Normal:Normal' },
}

local results_opt = {
  focusable = false,
  border = {
    style = {
      top_left = '├',
      top = '─',
      top_right = '┤',
      left = '│',
      right = '│',
      bottom_left = '',
      bottom = '',
      bottom_right = '',
    },
    text = { top = '' },
  },
  win_options = { winhighlight = 'Normal:Normal' },
}

local preview_opt = {
  focusable = false,
  border = {
    style = {
      top_left = '┌',
      top = '─',
      top_right = '┐',
      left = '│',
      right = '│',
      bottom_left = '',
      bottom = '',
      bottom_right = '',
    },
    text = { top = '' },
  },
  win_options = { winhighlight = 'Normal:Normal' },
}

local function new_popup(opt)
  return TsLayout.Window(Popup(opt))
end

local function create_layout(picker)
  local prompt = new_popup(prompt_opt)
  local preview = new_popup(preview_opt)
  local results = new_popup(results_opt)
  local layout_opt = {
    relative = 'editor',
    position = '53%',
    size = picker.layout_config.size,
  }

  local normal_box = Layout.Box(
    {
      Layout.Box(preview, { grow = 1 }),
      Layout.Box(results, { size = '30%' }),
      Layout.Box(prompt, { size = 3 }),
    },
    { dir = 'col' }
  )

  local minimal_box = Layout.Box(
    {
      Layout.Box(results, { grow = 1 }),
      Layout.Box(prompt, { size = 3 }),
    },
    { dir = 'col' }
  )

  local function get_box()
    if vim.o.lines < 20 then
      return minimal_box, 'minimal'
    else
      return normal_box, 'normal'
    end
  end

  local function patch_results(layout, box_ty)
    if box_ty == 'minimal' then
      layout.preview = nil
      results.border:set_style {
        top_left = '┌',
        top_right = '┐',
      }
    else
      layout.preview = preview
      results.border:set_style(results_opt.border.style)
    end
  end

  local box, box_ty = get_box()
  local layout = Layout(layout_opt, box)
  layout.picker = picker
  layout.prompt = prompt
  layout.results = results
  layout.preview = preview
  patch_results(layout, box_ty)

  local raw_layout_update = layout.update
  function layout:update(_, _, _)
    local new_box, new_box_ty = get_box()
    patch_results(layout, new_box_ty)
    raw_layout_update(self, layout_opt, new_box)
  end

  return TsLayout(layout)
end

-- enable line number for preview
vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  callback = function()
    vim.cmd.setlocal 'number'
  end,
})

return create_layout
