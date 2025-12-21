return function(entry1, entry2)
  local label1 = entry1:get_completion_item().label
  local label2 = entry2:get_completion_item().label

  if label1 == 'unsafe' then return false end
  if label2 == 'unsafe' then return true end
end
