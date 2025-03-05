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
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = false,
        },
      }

      opts.messages = {
        view = 'mini',
      }

      opts.presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
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

  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = { '*' },
  },

  {
    'laytan/cloak.nvim',
    ft = 'dotenv',
    ---@module 'cloak'
    opts = {
      patterns = {
        {
          file_pattern = '.env*',
          cloak_pattern = {
            '(%u+_ID)=.+',
            '(%u+_DSN)=.+',
            '(%u+_KEY)=.+',
            '(%u+_PASS%u+)=.+',
            '(%u+_PRIVATE%u+)=.+',
            '(%u+_SECRET%u+)=.+',
            '(%u+_TOKEN%u+)=.+',
            '(%u+_USER%u+)=.+',
            '(%u+)=(%a+://).+',
            '(%u+)=[\'"](%a+://).+[\'"]$',
          },
          replace = '%1=',
        },
      },
    },
  },
}
