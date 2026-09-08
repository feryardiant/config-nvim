return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    dependencies = {
      { 'LiadOz/nvim-dap-repl-highlights', config = true },
    },
    ---@module 'nvim-treesitter'
    ---@type TSConfig
    opts = {
      -- Directory to install parsers and queries to
      install_dir = vim.fn.stdpath('data') .. '/site',
    },
    ---@module 'nvim-treesitter'
    ---@param opts TSConfig
    config = function(_, opts)
      local nvim_treesitter = require('nvim-treesitter')

      nvim_treesitter.setup(opts)

      -- Register the custom `dotenv` parser via the `TSUpdate` user event so it
      -- survives nvim-treesitter's internal parser reload during install.
      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function()
          local parsers = require('nvim-treesitter.parsers')
          parsers['dotenv'] = {
            install_info = {
              url = 'https://github.com/pnx/tree-sitter-dotenv',
              files = { 'src/parser.c', 'src/scanner.c' },
              branch = 'main',
            },
            filetype = 'dotenv',
          }
        end,
      })

      -- Start treesitter highlighting for every filetype. Treesitter takes
      -- precedence over Vim's regex syntax highlighting for the nodes it
      -- captures, so this makes treesitter the primary highlighter. Vim syntax
      -- remains as a fallback for languages without a treesitter parser.
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- Install parsers (no-op if already installed). `ensure_installed` was
      -- removed in the nvim-treesitter rewrite, so install explicitly.
      nvim_treesitter.install {
        'bash',
        'blade',
        'css',
        'dotenv',
        'dap_repl',
        'editorconfig',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'html',
        'json',
        'javascript',
        'latex',
        'luadoc',
        'nginx',
        'php',
        'phpdoc',
        'php_only',
        'regex',
        'scss',
        'svelte',
        'toml',
        'tsx',
        'typescript',
        'typst',
        'vue',
        'yaml',
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
          -- ['.*%.blade%.php'] = 'blade',
          ['.*%.neon%.dist'] = 'yaml',
        },
      })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' }
    },
    ---@module 'nvim-treesitter-textobjects'
    ---@type TSTextObjects.UserConfig
    opts = {
      select = {
        lookahead = true,
        selection_modes = {
          ['@function.outer'] = 'V',
          ['@parameter.outer'] = 'v',
        },
      },
    },
    ---@param opts TSTextObjects.UserConfig
    config = function(_, opts)
      require('nvim-treesitter-textobjects').setup(opts)

      local select = require('nvim-treesitter-textobjects.select')
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        select.select_textobject('@function.inner', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'af', function()
        select.select_textobject('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        select.select_textobject('@class.inner', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        select.select_textobject('@class.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'il', function()
        select.select_textobject('@loop.inner', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'al', function()
        select.select_textobject('@loop.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'ia', function()
        select.select_textobject('@parameter.inner', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'aa', function()
        select.select_textobject('@parameter.outer', 'textobjects')
      end)
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
      max_lines = 3,
    },
  },
}
