local k = require 'infra.key'
local plugin = require 'catppuccin'

plugin.setup {
  styles = {
    miscs = {},
    comments = {},
    conditionals = {},
  },
  highlight_overrides = {
    all = {
      ['@lsp.type.unresolvedReference.rust'] = { link = 'Error' },
    },
    latte = {
      ErrorMsg = { fg = '#d20f39', style = {} },
      CurSearch = { fg = '#6420aa', bg = '#ffb5da' },
      CursorLine = { bg = '#fafafa' },
      TodoFgNote = { fg = '#40a02b' },
      TodoBgNote = { fg = '#eff1f5', bg = '#40a02b', bold = true },
      TodoBgHack = { fg = '#eff1f5', bg = '#df8e1d', bold = true },
      TodoBgWarn = { fg = '#eff1f5', bg = '#df8e1d', bold = true },
      TodoFgPerf = { fg = '#fe640b' },
      TodoBgPerf = { fg = '#eff1f5', bg = '#fe640b', bold = true },
      TodoFgTest = { fg = '#fe640b' },
      TodoBgTest = { fg = '#eff1f5', bg = '#fe640b', bold = true },
      TodoBgTODO = { fg = '#eff1f5', bg = '#04a5e5', bold = true },
      TrailingSpace = { bg = '#ffc800' },
      BinaryJumpMid = { link = 'ErrorMsg' },
      BinaryJumpRange = { link = 'DiagnosticVirtualTextOk' },
      CmpItemAbbrMatch = { fg = '#6420aa', style = {} },
      CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
      CmpMenuCursorLine = { bg = '#e6e9ef', bold = true },
      NeoTreeGitConflict = { fg = '#ed1b24' },
      NeoTreeGitUntracked = { fg = '#40a02b' },
      GitConflictSepMark = { fg = '#19b9e7', bg = '#dcf4fb' },
      GitConflictBoundMark = { fg = '#ed1b24', bg = '#fbd1d3' },
      QuickFixLine = { bg = '#d8ecd4' },
      ['@variable.builtin'] = { fg = '#1182a2' },
      ['@lsp.type.enumMember'] = { link = '@constant.builtin' },
    },
    frappe = {
      ErrorMsg = { fg = '#d20f39', style = {} },
      CurSearch = { fg = '#6420aa', bg = '#ffb5da' },
      CursorLine = { bg = '#dddddd' },
      TodoFgNote = { fg = '#40a02b' },
      TodoBgNote = { fg = '#eff1f5', bg = '#40a02b', bold = true },
      TodoBgHack = { fg = '#eff1f5', bg = '#df8e1d', bold = true },
      TodoBgWarn = { fg = '#eff1f5', bg = '#df8e1d', bold = true },
      TodoFgPerf = { fg = '#fe640b' },
      TodoBgPerf = { fg = '#eff1f5', bg = '#fe640b', bold = true },
      TodoFgTest = { fg = '#fe640b' },
      TodoBgTest = { fg = '#eff1f5', bg = '#fe640b', bold = true },
      TodoBgTODO = { fg = '#eff1f5', bg = '#04a5e5', bold = true },
      TrailingSpace = { bg = '#ffc800' },
      BinaryJumpMid = { link = 'ErrorMsg' },
      BinaryJumpRange = { link = 'DiagnosticVirtualTextOk' },
      CmpItemAbbrMatch = { fg = '#6420aa', style = {} },
      CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
      CmpMenuCursorLine = { bg = '#efece6', bold = true },
      NeoTreeGitConflict = { fg = '#ed1b24' },
      NeoTreeGitUntracked = { fg = '#40a02b' },
      GitConflictSepMark = { fg = '#19b9e7', bg = '#dcf4fb' },
      GitConflictBoundMark = { fg = '#ed1b24', bg = '#fbd1d3' },
      QuickFixLine = { bg = '#d8ecd4' },
      ['@variable.builtin'] = { fg = '#1182a2' },
      ['@lsp.type.enumMember'] = { link = '@constant.builtin' },
    },
    macchiato = {
      ErrorMsg = { fg = '#ed8796', style = {} },
      CurSearch = { fg = '#ffb5da', bg = '#6420aa' },
      CursorLine = { bg = '#2e324a' },
      TodoFgNote = { fg = '#83c66d' },
      TodoBgNote = { fg = '#24273a', bg = '#83c66d', bold = true },
      TodoFgPerf = { fg = '#f5a97f' },
      TodoBgPerf = { fg = '#24273a', bg = '#f5a97f', bold = true },
      TodoFgTest = { fg = '#f5a97f' },
      TodoBgTest = { fg = '#24273a', bg = '#f5a97f', bold = true },
      TodoFgFix = { fg = '#e65d5a' },
      TodoBgFix = { fg = '#24273a', bg = '#e65d5a', bold = true },
      TrailingSpace = { bg = '#ffc800' },
      BinaryJumpMid = { link = 'ErrorMsg' },
      BinaryJumpRange = { link = 'DiagnosticVirtualTextOk' },
      CmpItemAbbrMatch = { fg = '#ffb5da', style = {} },
      CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
      CmpMenuCursorLine = { bg = '#1E2030', bold = true },
      NeoTreeGitConflict = { fg = '#e65d5a' },
      NeoTreeGitUntracked = { fg = '#83c66d' },
      GitConflictSepMark = { fg = '#16abd6', bg = '#041d24' },
      GitConflictBoundMark = { fg = '#e65d5a', bg = '#270706' },
      QuickFixLine = { bg = '#272f25' },
      ['@variable.builtin'] = { fg = '#16d4d1' },
      ['@lsp.type.enumMember'] = { link = '@constant.builtin' },
    },
    mocha = {
      ErrorMsg = { fg = '#f38ba8', style = {} },
      CurSearch = { fg = '#ffb5da', bg = '#6420aa' },
      CursorLine = { bg = '#252636' },
      TodoFgNote = { fg = '#83c66d' },
      TodoBgNote = { fg = '#1e1e2e', bg = '#83c66d', bold = true },
      TodoFgPerf = { fg = '#f5a97f' },
      TodoBgPerf = { fg = '#1e1e2e', bg = '#f5a97f', bold = true },
      TodoFgTest = { fg = '#f5a97f' },
      TodoBgTest = { fg = '#1e1e2e', bg = '#f5a97f', bold = true },
      TodoFgFix = { fg = '#e65d5a' },
      TodoBgFix = { fg = '#1e1e2e', bg = '#e65d5a', bold = true },
      TrailingSpace = { bg = '#ffc800' },
      BinaryJumpMid = { link = 'ErrorMsg' },
      BinaryJumpRange = { link = 'DiagnosticVirtualTextOk' },
      CmpItemAbbrMatch = { fg = '#ffb5da', style = {} },
      CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
      CmpMenuCursorLine = { bg = '#181825', bold = true },
      NeoTreeGitConflict = { fg = '#e65d5a' },
      NeoTreeGitUntracked = { fg = '#83c66d' },
      GitConflictSepMark = { fg = '#16abd6', bg = '#020f13' },
      GitConflictBoundMark = { fg = '#e65d5a', bg = '#160403' },
      QuickFixLine = { bg = '#272f25' },
      ['@variable.builtin'] = { fg = '#16d4d1' },
      ['@lsp.type.enumMember'] = { link = '@constant.builtin' },
    },
  },
  color_overrides = {
    latte = {
      maroon = '#1182a2',
    },
    frappe = {
      rosewater = '#dc8a78',
      flamingo = '#dd7878',
      pink = '#ea76cb',
      mauve = '#8839ef',
      red = '#d20f39',
      peach = '#fe640b',
      yellow = '#df8e1d',
      green = '#40a02b',
      teal = '#179299',
      sky = '#04a5e5',
      sapphire = '#209fb5',
      blue = '#1e66f5',
      lavender = '#7287fd',
      text = '#4c4f69',
      subtext1 = '#5c5f77',
      subtext0 = '#6c6f85',
      overlay2 = '#7c7f93',
      overlay1 = '#8c8fa1',
      overlay0 = '#9ca0b0',
      surface2 = '#acb0be',
      surface1 = '#bcc0cc',
      surface0 = '#ccd0da',
      -- colors not from latte
      maroon = '#1182a2',
      base = '#f5f3ef',
      mantle = '#efece6',
      crust = '#e8e4dc',
    },
    macchiato = {
      maroon = '#16d4d1',
    },
    mocha = {
      maroon = '#16d4d1',
    },
  },
  integrations = {
    native_lsp = {
      virtual_text = {
        ok = {},
        hints = {},
        errors = {},
        warnings = {},
        information = {},
      },
      underlines = {
        ok = { 'undercurl' },
        hints = { 'undercurl' },
        errors = { 'undercurl' },
        warnings = { 'undercurl' },
        information = { 'undercurl' },
      },
    },
  },
}

local rev = false
vim.cmd.colorscheme 'catppuccin-latte'

-- cycle colorscheme
local colorschemes = {
  'catppuccin-latte',
  'catppuccin-frappe',
  'catppuccin-macchiato',
  'catppuccin-mocha',
}
k.map('n', 'ts', function()
  local curr = vim.g.colors_name
  for i, it in ipairs(colorschemes) do
    if curr == it then
      if i == 1 or i == 4 then rev = not rev end
      if rev then
        vim.cmd.colorscheme(colorschemes[i - 1])
      else
        vim.cmd.colorscheme(colorschemes[i + 1])
      end
      return
    end
  end
end)
