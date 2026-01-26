local unmap = require 'infra.key'.unmap

-- search backward
unmap('n', '?')
-- select word backward
unmap('x', 'b')
-- recording
unmap({ 'n', 'x' }, 'q')
-- key chord
unmap({ 'x', 'i' }, '<C-k>')
-- jump to next word
unmap({ 'n', 'x' }, 'w')
-- replace
unmap({ 'n', 'x' }, 'r')

-- move cursor left/up/down
unmap({ 'n', 'x' }, '<Bs>')
unmap({ 'n', 'x' }, '<C-p>')
unmap({ 'n', 'x' }, '<C-m>')

-- go page head/end
unmap({ 'n', 'x' }, 'H')
unmap({ 'n', 'x' }, 'L')

-- go line head/end
unmap({ 'n', 'x' }, '0')
unmap({ 'n', 'x' }, '$')

-- right click combo
unmap({ 'n', 'x', 'i' }, '<2-RightMouse>')
unmap({ 'n', 'x', 'i' }, '<3-RightMouse>')
unmap({ 'n', 'x', 'i' }, '<4-RightMouse>')

-- delete combo
unmap('n', 'dh')
unmap('n', 'dj')
unmap('n', 'dk')
unmap('n', 'dl')

-- history list
unmap('c', '<C-f>')
unmap({ 'n', 'x' }, 'q:')
unmap({ 'n', 'x' }, 'q/')
unmap({ 'n', 'x' }, 'q?')
