return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter' },
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'onsails/lspkind.nvim' },
    },
    ---@module 'cmp'
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require('cmp')
      local kind_icons = {
        BladeNav = '',
      }

      opts.sources = cmp.config.sources({
        {
          name = 'nvim_lsp',
          priority = 100,
          group_index = 1,
        },
        {
          name = 'luasnip',
          priority = 90,
          group_index = 2,
          option = { show_autosnippets = true },
        },
        { name = 'path', group_index = 0 },
        { name = 'lazydev', group_index = 0 },
      }, {
        { name = 'buffer', keyword_length = 5 },
      })

      opts.sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.kind,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }

      opts.formatting = {
        expandable_indicator = true,
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, item)
          if kind_icons[item.kind] then
            -- Set custom kind icons
            item.kind = string.format('%s %s', kind_icons[item.kind], item.kind)
          end

          return require('lspkind').cmp_format({
            mode = 'symbol',
          })(entry, item)
        end,
      }

      opts.snippet = {
        expand = function(args)
          -- Set luasnip as default snippet engine
          require('luasnip').lsp_expand(args.body)
        end,
      }

      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      opts.mapping = cmp.mapping.preset.insert({
        ['<C-space>'] = cmp.mapping.complete(),
        ['<Esc>'] = cmp.mapping.abort(),

        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),

        ['<Tab>'] = cmp.mapping(function(fallback)
          local ls = require('luasnip')

          if cmp.visible() then
            cmp.select_next_item()
          elseif ls.expand_or_locally_jumpable() then
            ls.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          local ls = require('luasnip')

          if cmp.visible() then
            cmp.select_prev_item()
          elseif ls.locally_jumpable(-1) then
            ls.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      })
    end,
  },
}
