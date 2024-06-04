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

local function format(_, it)
  if it.kind ~= nil then
    local index = kind[it.kind]
    if index ~= nil then
      it.kind = kind[index]
    end
  end
  if it.abbr ~= nil then
    it.abbr = string.sub(it.abbr, 1, 24)
  end
  if it.menu ~= nil then
    it.menu = string.sub(it.menu, 1, 80)
  end
  return it
end

return format
