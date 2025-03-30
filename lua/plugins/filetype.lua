local M = {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    dependencies = {
      { 'Bilal2453/luvit-meta' },
    },
    ---@module 'lazydev'
    ---@type lazydev.Config
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { 'nvim-dap-ui' },
      },
    },
  },

  {
    'ricardoramirezr/blade-nav.nvim',
    dependencies = {
      { 'saghen/blink.compat' },
    },
    ft = { 'blade', 'php' },
    opts = {
      close_tag_on_complete = false, -- default: true
    },
  },
}

if vim.fn.executable('ghostty') then
  table.insert(M, {
    'ghostty',
    dir = '/Applications/Ghostty.app/Contents/Resources/vim/vimfiles/',
    ft = 'ghostty',
  })
end

return M
