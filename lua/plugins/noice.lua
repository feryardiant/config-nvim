return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'MunifTanjim/nui.nvim' },
    },
    ---@module 'noice'
    ---@param opts NoiceConfig
    opts = function(_, opts)
      opts.lsp = {
        override = {
          -- ['cmp.entry.get_documentation'] = false,
          -- ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      }

      opts.messages = {
        view = 'mini',
      }

      opts.presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      }

      opts.routes = {
        -- Credit: https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-2138428768
        {
          filter = {
            event = 'notify',
            find = 'No information available',
          },
          opts = { skip = true },
        },
      }
    end,
  },
}
