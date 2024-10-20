return function(entry1, entry2)
  local it1 = entry1:get_completion_item()
  local it2 = entry2:get_completion_item()

  if it1.cmp ~= nil and it1.cmp.kind_text == 'v' and it2.cmp == nil then return true end
  if it2.cmp ~= nil and it2.cmp.kind_text == 'v' and it1.cmp == nil then return false end
end
