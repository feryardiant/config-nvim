return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },

  -- Show context of the current function
  {
    'nvim-treesitter/nvim-treesitter-context',
    lazy = true,
    opts = {
      mode = 'cursor',
      max_line = 3,
    },
  },

  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'nvim-treesitter/playground' },
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'JoosepAlviste/nvim-ts-context-commentstring' },
      { 'nvim-treesitter/nvim-treesitter-context', enabled = true },
    },
    opts = {
      indent = { enable = true },
      highlight = { enable = true },
      -- A list of parser names
      ensure_installed = {
        'bash',
        'blade',
        'comment',
        'gitignore',
        'html',
        'json',
        'javascript',
        'markdown',
        'markdown_inline',
        'php',
        'phpdoc',
        'php_only',
        'toml',
        'typescript',
        'tsx',
        'vim',
        'vimdoc',
        'vue',
        'yaml',
      },
      -- Install parsers asynchronously
      sync_install = false,
      -- Auto install missing parsers when entering buffer
      auto_install = true,
      -- Incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          node_decremental = '<bs>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['if'] = '@function.inner',
            ['af'] = '@function.outer',
            ['ic'] = '@class.inner',
            ['ac'] = '@class.outer',
            ['il'] = '@loop.inner',
            ['al'] = '@loop.outer',
            ['ia'] = '@parameter.inner',
            ['aa'] = '@parameter.outer',
          },
        },
      },
    },
    config = function(_, opts)
      local parser = require('nvim-treesitter.parsers')
      local parser_config = parser.get_parser_configs()

      parser_config['blade'] = {
        install_info = {
          url = 'https://github.com/EmranMR/tree-sitter-blade',
          files = { 'src/parser.c' },
          branch = 'main',
        },
        filetype = 'blade',
      }

      parser_config['dotenv'] = {
        install_info = {
          url = 'https://github.com/pnx/tree-sitter-dotenv',
          files = { 'src/parser.c', 'src/scanner.c' },
          branch = 'main',
        },
        filetype = 'dotenv',
      }

      vim.filetype.add({
        pattern = {
          ['.env.*'] = 'dotenv'
        }
      })

      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
