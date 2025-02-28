local map = require('util').create_keymap()
local noremap = require('util').create_keymap({ noremap = true })

-- Clear search with <ESC>
map('n', '<Esc>', '<Cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Diagnostics
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil

  return function() go({ severity = severity }) end
end

map('n', '[d', diagnostic_goto(false), { desc = 'Goto previous diagnostic' })
map('n', ']d', diagnostic_goto(true), { desc = 'Goto next diagnostic' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Goto previous error' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Goto next error' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Goto previous warning' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Goto next warning' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

noremap('n', 'J', 'mzJ`z', { desc = 'Move line below to end of current line' })

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

-- Speed up viewport scrolling
-- map('n', '<C-J>', '4<C-e>', { desc = 'Scroll 4 lines down' })
-- map('n', '<C-K>', '4<C-y>', { desc = 'Scroll 4 lines up' })

-- Buffers navigation
noremap('n', '<Tab>', vim.cmd.bnext, { desc = 'Next Buffer' })
noremap('n', '<S-Tab>', vim.cmd.bprevious, { desc = 'Previous Buffer' })

-- Keep cursor in the middle while navigate through search results
noremap('n', 'n', 'nzzzv', { desc = 'Previeous search result' })
noremap('n', 'N', 'Nzzzv', { desc = 'Next search result' })

-- Better indenting on visual mode
map('v', '<', '<gv', { desc = 'Dedent line' })
map('v', '>', '>gv', { desc = 'Indent line' })

-- Copy to system clipboard
noremap({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
noremap({ 'n', 'v' }, '<leader>Y', '"+Y', { desc = 'Copy to system clipboard' })

-- Delete word without leaving the trace
-- https://learnvim.irian.to/basics/registers
-- noremap({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete word' })
