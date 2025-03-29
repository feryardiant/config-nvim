vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'dap-repl', 'qf', 'help', 'netrw', 'man', 'nofile', 'lspinfo' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false

    vim.wo.colorcolumn = ''
    vim.wo.statuscolumn = ''
    vim.wo.signcolumn = 'no'

    vim.api.nvim_buf_set_keymap(event.buf, 'n', 'q', '<Cmd>close<CR>', { silent = true })
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    -- Highlight yanked line(s)
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  callback = function()
    -- Disable status column on DAP-UI panels
    if vim.bo.ft:match('^dapui_') then
      vim.wo.statuscolumn = ''
      vim.wo.colorcolumn = ''
      vim.wo.signcolumn = 'no'
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dap-repl',
  callback = function()
    ---@see dap-completion
    require('dap.ext.autocompl').attach()
  end,
})
