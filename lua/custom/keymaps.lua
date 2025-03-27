local keymap = require('utils.keymap')
local map = keymap.create()
local noremap = keymap.create({ noremap = true })

-- Clear search with <ESC>
map('n', '<Esc>', '<Cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Keep cursor in the middle while navigate through search results
noremap('n', 'n', 'nzzzv', { desc = 'Previeous search result' })
noremap('n', 'N', 'Nzzzv', { desc = 'Next search result' })

-- Keep cursor in the middle while scrolling page
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Better indenting on visual mode
map('v', '<', '<gv', { desc = 'Dedent line' })
map('v', '>', '>gv', { desc = 'Indent line' })

-- Buffers navigation - Use Tab/Shift-Tab to navigate between buffers
noremap('n', '<Tab>', vim.cmd.bnext, { desc = 'Next Buffer' })
noremap('n', '<S-Tab>', vim.cmd.bprevious, { desc = 'Previous Buffer' })

-- Move lines - Use ALT+J/K to move line up and down
noremap('n', '<A-j>', '<Cmd>move+1<CR>==', { desc = 'Move lines down' })
noremap('n', '<A-k>', '<Cmd>move-2<CR>==', { desc = 'Move lines up' })
noremap('i', '<A-j>', '<Esc><Cmd>move+1<CR>==gi', { desc = 'Move lines down' })
noremap('i', '<A-k>', '<Esc><Cmd>move-2<CR>==gi', { desc = 'Move lines up' })
noremap('v', '<A-j>', ":move'>+1<CR>gv=gv", { desc = 'Move lines down' })
noremap('v', '<A-k>', ":move'<-2<CR>gv=gv", { desc = 'Move lines up' })

-- Split navigation - Use CTRL+H/J/K/L to navigate window
noremap('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
noremap('n', '<C-j>', '<C-w>j', { desc = 'Go to window below' })
noremap('n', '<C-k>', '<C-w>k', { desc = 'Go to window above' })
noremap('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Resize window - Use ALT+ArrowKeys to resize windows
map('n', '<A-Up>', '<Cmd>resize+2<CR>', { desc = 'Increase window height' })
map('n', '<A-Down>', '<Cmd>resize-2<CR>', { desc = 'Decrease window height' })
map('n', '<A-Left>', '<Cmd>vertical resize-2<CR>', { desc = 'Decrease window width' })
map('n', '<A-Right>', '<Cmd>vertical resize+2<CR>', { desc = 'Increase window width' })
