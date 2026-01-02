local plugin = require 'catppuccin'

plugin.setup {
  styles = {
    miscs = {},
    comments = {},
    conditionals = {},
  },
  highlight_overrides = {
    all = {
      BinaryJumpMid = { link = 'Character' },
      BinaryJumpNextMid = { link = 'DiffText' },
      BinaryJumpRange = { link = 'DiffChange' },
      CmpItemAbbrMatchFuzzy = { link = 'CmpItemAbbrMatch' },
      TelescopeMatching = { link = 'Search' },
      TelescopeSelection = { link = 'CursorLine' },
      ['@lsp.type.enumMember'] = { link = '@constant.builtin' },
      ['@lsp.type.unresolvedReference.rust'] = { link = 'Error' },
    },
    latte = {
      ErrorMsg = { fg = '#d20f39', style = {} },
      CurSearch = { fg = '#6420aa', bg = '#ffb5da' },
      CursorLine = { bg = '#fafafa' },
      ColorColumn = { bg = '#d7d8dc' },
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
      CmpItemAbbrMatch = { fg = '#6420aa', style = {} },
      CmpMenuCursorLine = { bg = '#e6e9ef', bold = true },
      NeoTreeGitConflict = { fg = '#ed1b24' },
      NeoTreeGitUntracked = { fg = '#40a02b' },
      GitConflictSepMark = { fg = '#19b9e7', bg = '#dcf4fb' },
      GitConflictBoundMark = { fg = '#ed1b24', bg = '#fbd1d3' },
      QuickFixLine = { bg = '#d8ecd4' },
      ['@variable.builtin'] = { fg = '#1182a2' },
    },
  },
  color_overrides = {
    latte = {
      maroon = '#1182a2',
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

vim.cmd.colorscheme 'catppuccin-latte'
