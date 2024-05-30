local kind_map = {
  ['Enum'] = '󰣥',
  ['Text'] = '󰊄',
  ['Field'] = '󱪲',
  ['Value'] = '󰢡',
  ['Module'] = '󰐱',
  ['Method'] = '󰊕',
  ['Struct'] = '󱊈',
  ['Keyword'] = ' ',
  ['Snippet'] = '󰉁',
  ['Constant'] = '󰨓',
  ['Variable'] = '󰫧',
  ['Function'] = '󰊕',
  ['Interface'] = '󱘖',
  ['Reference'] = ' ',
  ['EnumMember'] = '󱇠',
}

local function format(_, it)
  if it.kind ~= nil and kind_map[it.kind] ~= nil then
    it.kind = kind_map[it.kind]
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
