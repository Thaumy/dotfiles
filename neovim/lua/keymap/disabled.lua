local unmap = require 'infra.key'.unmap

unmap({ 'v', 'i' }, '<C-k>') -- key chord
unmap({ 'n', 'v' }, '<C-m>') -- down
unmap({ 'n', 'v' }, '<C-p>') -- up
unmap({ 'n', 'v' }, 'H')     -- go page start
unmap({ 'n', 'v' }, 'L')     -- go page end
unmap('n', '?')              -- search backward
unmap('v', 'b')              -- select word backward
unmap({ 'n', 'v' }, 'q')     -- recording
unmap({ 'n', 'v' }, '0')     -- go line head
unmap({ 'n', 'v' }, '$')     -- go line end

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
