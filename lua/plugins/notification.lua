return {
  {
    'rcarriga/nvim-notify',
    lazy = true,
    ---@module 'notify'
    ---@type notify.Config
    opts = {
      minimum_width = 25,
      -- max_width = 50,
      background_colour = '#000000',
    },
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
      { 'rcarriga/nvim-notify' },
    },
    ---@module 'noice'
    ---@type NoiceConfig
    opts = {
      lsp = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = false,
        -- signature = {
        --   enabled = false,
        -- },
        -- hover = {
        --   enabled = false
        -- }
      },
      messages = {
        view = 'mini',
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      routes = {
        -- Credit: https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-2138428768
        {
          filter = {
            event = 'notify',
            find = 'No information available',
          },
          opts = {
            skip = true,
          },
        },
      },
    },
  },
}
