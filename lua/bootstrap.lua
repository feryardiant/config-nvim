vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Open checkhealth in floating window, see `:h g:health`
vim.g.health = { style = 'float' }

require('custom.autocmds')
require('custom.options')
require('custom.keymaps')
