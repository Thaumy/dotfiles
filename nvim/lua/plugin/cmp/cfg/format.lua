local kind = {
  '󰊄', -- Text
  '󰊕', -- Method
  '󰊕', -- Function
  '󰆩', -- Constructor
  '󱪲', -- Field
  '󰫧', -- Variable
  '󰆧', -- Class
  '󱘖', -- Interface
  '󰐱', -- Module
  '󰊕', -- Property
  '󰑭', -- Unit
  '󰢡', -- Value
  '󰣥', -- Enum
  ' ', -- Keyword
  '󰉁', -- Snippet
  '󰏘', -- Color
  '󰈙', -- File
  '󰪍', -- Reference
  '󰉋', -- Folder
  '󱇠', -- EnumMember
  '󰨓', -- Constant
  '󱊈', -- Struct
  '󰂚', -- Event
  '󱓉', -- Operator
  '󰬁', -- TypeParameter
  Class = 7,
  Color = 16,
  Constant = 21,
  Constructor = 4,
  Enum = 13,
  EnumMember = 20,
  Event = 23,
  Field = 5,
  File = 17,
  Folder = 19,
  Function = 3,
  Interface = 8,
  Keyword = 14,
  Method = 2,
  Module = 9,
  Operator = 24,
  Property = 10,
  Reference = 18,
  Snippet = 15,
  Struct = 22,
  Text = 1,
  TypeParameter = 25,
  Unit = 11,
  Value = 12,
  Variable = 6,
}
vim.lsp.protocol.CompletionItemKind = kind

local function format(entry, it)
  if it.kind ~= nil then
    local index = kind[it.kind]
    if index ~= nil then
      it.kind = kind[index]
    end
  end

  local hl = require 'colorful-menu'.cmp_highlights(entry)
  if hl ~= nil then
    it.menu = nil
    it.abbr_hl_group = hl.highlights
    it.abbr = hl.text
    return it
  end

  local term_width = vim.go.columns

  local max_abbr_width = term_width * 0.2
  if it.abbr ~= nil and #it.abbr > max_abbr_width then
    it.abbr = string.sub(it.abbr, 1, max_abbr_width) .. '…'
  end

  local max_menu_width = term_width * 0.4
  if it.menu ~= nil and #it.menu > max_menu_width then
    it.menu = string.sub(it.menu, 1, max_menu_width) .. '…'
  end

  return it
end

return format
