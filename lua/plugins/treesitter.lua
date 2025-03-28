return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      { 'LiadOz/nvim-dap-repl-highlights', config = true },
    },
    ---@module 'nvim-treesitter'
    ---@type TSConfig
    opts = {
      indent = { enable = true },
      highlight = { enable = true },
      -- A list of parser names
      ensure_installed = {
        'bash',
        'blade',
        'dotenv',
        'dap_repl',
        'gitignore',
        'html',
        'json',
        'javascript',
        'lua',
        'markdown',
        'markdown_inline',
        'php',
        'phpdoc',
        'php_only',
        'toml',
        'typescript',
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
        extension = {
          keymap = 'dst',
          neon = 'yaml',
          overlay = 'dst',
        },
        pattern = {
          ['.env.*'] = 'dotenv',
          ['.aliases'] = 'bash',
          ['.exports'] = 'bash',
          ['.functions'] = 'bash',
          ['.profile'] = 'bash',
          ['.*%.blade%.php'] = 'blade',
          ['.*%.neon%.dist'] = 'yaml',
        },
      })

      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    ---@module 'nvim-ts-autotag'
    ---@type nvim-ts-autotag.PluginSetup
    opts = {},
  },

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    ---@module 'ts_context_commentstring'
    ---@type ts_context_commentstring.Config
    opts = {
      enable_autocmd = false,
    },
  },

  -- Show context of the current function
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    ---@module 'treesitter-context'
    ---@type TSContext.UserConfig
    opts = {
      mode = 'cursor',
      max_line = 3,
    },
  },
}
