-- Delete default keymap
vim.keymap.del('n', 'gra') -- code_action
vim.keymap.del('n', 'grn') -- rename
vim.keymap.del('n', 'grr') -- references
vim.keymap.del('n', 'gri') -- implementation

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local keymap = require('utils.keymap')
    local map = keymap.create({ buffer = event.buf, remap = true, desc = 'LSP: ' })

    map('n', 'gd', Snacks.picker.lsp_definitions, { desc = '[G]oto [D]efinition' })
    map('n', 'gD', Snacks.picker.lsp_declarations, { desc = '[G]oto [D]eclaration' })
    map('n', 'gr', Snacks.picker.lsp_references, { desc = '[G]oto [R]eferences', nowait = true })
    map('n', 'gi', Snacks.picker.lsp_implementations, { desc = '[G]oto [I]mplementation' })
    map('n', 'gy', Snacks.picker.lsp_type_definitions, { desc = '[G]oto T[y]pe Definition' })
    map('n', '<leader>s', Snacks.picker.lsp_workspace_symbols, { desc = 'Workspace Symbols' })
    map('n', '<leader>ss', Snacks.picker.lsp_symbols, { desc = 'Document Symbols' })

    map('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame Symbol' })
    map({ 'n', 'x' }, '<C-.>', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if not client then return end

    -- Credit: https://github.com/nvim-lua/kickstart.nvim/blob/7201dc4/init.lua#L555-L588
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
          vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = e.buf })
        end,
      })
    end
  end,
})

return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'neovim/nvim-lspconfig' },
      { 'saghen/blink.cmp' },
    },
    ---@module 'mason-lspconfig'
    ---@param opts MasonLspconfigSettings
    opts = function(_, opts)
      opts.ensure_installed = {
        'bashls',
        'cssls',
        'dockerls',
        'emmet_ls',
        'eslint',
        'intelephense',
        'jsonls',
        'lua_ls',
        'nginx_language_server',
        'sqls',
        'svelte',
        'ts_ls',
        'tailwindcss',
        'vimls',
        'volar',
        'yamlls',
      }

      opts.handlers = {
        -- Default handler for all available LSP server.
        ---@param server string
        function(server)
          local lspconfig = require('lspconfig')
          local servers = require('custom.lsp-servers')

          ---@type lspconfig.Config
          local config = servers[server]

          config.capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            require('blink.cmp').get_lsp_capabilities(config.capabilities or {})
          )

          lspconfig[server].setup(config)
        end,
      }
    end,
  },
}
