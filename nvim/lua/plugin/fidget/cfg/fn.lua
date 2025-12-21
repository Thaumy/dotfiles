local function lsp_progress_message_fmt(msg)
  if msg.message == nil then
    return ''
  end

  if msg.percentage ~= nil then
    local bar_lhs_len = msg.percentage / 10
    local bar_lhs = string.rep('▓', bar_lhs_len)
    local bar_rhs = string.rep('░', 10 - bar_lhs_len)

    return string.format('%s %s%s', msg.message, bar_lhs, bar_rhs)
  end

  return msg.message
end

return {
  blink_icon = '󰞌 ',
  lsp_progress_message_fmt = lsp_progress_message_fmt,
}
