local unmap = require 'infra.key'.unmap

-- search backward
unmap('n', '?')
-- select word backward
unmap('v', 'b')
-- recording
unmap({ 'n', 'v' }, 'q')
-- key chord
unmap({ 'v', 'i' }, '<C-k>')

-- move cursor up/down
unmap({ 'n', 'v' }, '<C-p>')
unmap({ 'n', 'v' }, '<C-m>')

-- go page head/end
unmap({ 'n', 'v' }, 'H')
unmap({ 'n', 'v' }, 'L')

-- go line head/end
unmap({ 'n', 'v' }, '0')
unmap({ 'n', 'v' }, '$')

-- right click combo
unmap({ 'n', 'v', 'i' }, '<2-RightMouse>')
unmap({ 'n', 'v', 'i' }, '<3-RightMouse>')
unmap({ 'n', 'v', 'i' }, '<4-RightMouse>')

-- delete combo
unmap('n', 'dh')
unmap('n', 'dj')
unmap('n', 'dk')
unmap('n', 'dl')

-- history list
unmap('c', '<C-f>')
unmap({ 'n', 'v' }, 'q:')
unmap({ 'n', 'v' }, 'q/')
unmap({ 'n', 'v' }, 'q?')
