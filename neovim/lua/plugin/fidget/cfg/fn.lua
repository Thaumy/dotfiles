local blink_state = false

local function blink_icon(_)
  if blink_state then
    blink_state = false
    return '󰨓 '
  else
    blink_state = true
    return '  '
  end
end

local function lsp_progress_message_fmt(msg)
  if msg.message == nil then
    if msg.done then
      return 'Completed'
    else
      return 'In progress...'
    end
  end

  if msg.percentage ~= nil then
    local bar_lhs_len = msg.percentage / 10
    local bar_lhs = string.rep('▓', bar_lhs_len)
    local bar_rhs = string.rep('░', 10 - bar_lhs_len)

    return string.format('%s %s%s', msg.message, bar_lhs, bar_rhs)
  else
    return msg.message
  end
end

return {
  blink_icon = blink_icon,
  lsp_progress_message_fmt = lsp_progress_message_fmt,
}
