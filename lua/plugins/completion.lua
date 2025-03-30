return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    event = { 'InsertEnter' },
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
    },
    ---@module 'blink.cmp'
    ---@param opts blink.cmp.Config
    opts = function(_, opts)
      local function kind_icon(ctx)
        if ctx.item.source_id == 'blade_nav' then
          -- stylua : ignore
          return MiniIcons.get('filetype', 'blade')
        end

        return MiniIcons.get('lsp', ctx.kind)
      end

      opts.keymap = { preset = 'enter' }

      opts.completion = {
        documentation = { auto_show = true },

        ghost_text = { enabled = true },

        menu = {
          draw = {
            components = {
              -- Configure completion kind_icon using `mini.icons`
              -- https://cmp.saghen.dev/recipes.html#completion-menu-drawing
              kind_icon = {
                text = function(ctx)
                  local text, _ = kind_icon(ctx)

                  return text
                end,
                highlight = function(ctx)
                  local _, highlight = kind_icon(ctx)

                  return highlight
                end,
              },
            },
          },
        },
      }

      opts.snippets = { preset = 'mini_snippets' }

      opts.sources = {
        default = function()
          local ok, node = pcall(vim.treesitter.get_node)
          local workspace = require('utils.workspace')

          if ok and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_commet' }, node:type()) then
            -- Only provides `lsp` and `buffers` for any comments
            return { 'lsp', 'buffer' }
          elseif vim.tbl_contains({ 'php', 'blade' }, vim.bo.filetype) and workspace.is_laravel() then
            -- Provide `blade_nav` if it was a laravel project
            return { 'lsp', 'blade_nav', 'path', 'snippets', 'buffer' }
          end

          return { 'lsp', 'path', 'snippets', 'buffer' }
        end,

        providers = {
          blade_nav = {
            name = 'blade-nav',
            module = 'blink.compat.source',
          },
        },
      }

      opts.fuzzy = { implementation = 'prefer_rust_with_warning' }
    end,
  },

  {
    'saghen/blink.compat',
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = '*',
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {
      impersonate_nvim_cmp = true,
    },
  },
}
