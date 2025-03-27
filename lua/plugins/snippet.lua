return {
  {
    'saadparwaiz1/cmp_luasnip',
    lazy = true,
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      require('luasnip.config').set_config({
        history = true,
        delete_check_events = 'TextChanged',
      })

      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
}
