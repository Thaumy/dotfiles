function string.start_with(str, seq)
  return string.sub(str, 1, string.len(seq)) == seq
end

function string.skip(str, n)
  return string.sub(str, n, string.len(str))
end
