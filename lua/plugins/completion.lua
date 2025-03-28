local function kind_icon(ctx)
  if ctx.item.source_id == 'blade_nav' then
    -- stylua : ignore
    return MiniIcons.get('filetype', 'blade')
  end

  return MiniIcons.get('lsp', ctx.kind)
end

return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    event = { 'InsertEnter' },
    dependencies = {
      { 'rafamadriz/friendly-snippets' },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'enter' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = { auto_show = true },

        ghost_text = { enabled = true },

        menu = {
          draw = {
            components = {
              -- Configure completion kind_icon using `mini.icons`
              -- https://cmp.saghen.dev/recipes.html#completion-menu-drawing
              kind_icon = {
                text = function (ctx)
                  local text, _ = kind_icon(ctx)

                  return text
                end,
                highlight = function (ctx)
                  local _, highlight = kind_icon(ctx)

                  return highlight
                end,
              },
            },
          }
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'blade_nav', 'buffer' },
        providers = {
          blade_nav = {
            name = 'blade-nav',
            module = 'blink.compat.source',
          },
        },
      },

      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
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
