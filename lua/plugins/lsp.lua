return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/nvim-cmp' },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = require('utils.keymap').create({ buffer = event.buf, remap = false, desc = 'LSP: ' })

          -- map('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
          -- map({ 'n', 'x' }, '<C-.>', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

          -- map('n', 'K', vim.lsp.buf.hover, { desc = 'Show signature help' })

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if not client then return end

          -- Credit: https://github.com/nvim-lua/kickstart.nvim/blob/7201dc4/init.lua#L555-L588
          if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })

            vim.api.nvim_create_autocmd('CursorHold', {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd('CursorMoved', {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(e)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'lsp_document_highlight', buffer = e.buf })
              end,
            })
          end

          if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map(
              'n',
              '<leader>th',
              function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({
                  bufnr = event.buf,
                }))
              end,
              { desc = '[T]oggle Inlay [H]ints' }
            )
          end
        end,
      })
    end,
  },
}
