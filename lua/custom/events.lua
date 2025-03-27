vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf', 'help', 'netrw', 'man', 'nofile', 'lspinfo' },
  callback = function (event)
    vim.bo[event.buf].buflisted = false

    vim.wo.colorcolumn = ''
    vim.wo.statuscolumn = ''
    vim.wo.signcolumn = 'no'

    vim.api.nvim_buf_set_keymap(event.buf, 'n', 'q', '<Cmd>close<CR>', { silent = true })
  end
})

