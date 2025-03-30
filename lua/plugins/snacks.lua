local header =
  [[██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗    ██╗  ██╗ █████╗ ██████╗ ██████╗ ███████╗██████╗
██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝    ██║  ██║██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
██║ █╗ ██║██║   ██║██████╔╝█████╔╝     ███████║███████║██████╔╝██║  ██║█████╗  ██████╔╝
██║███╗██║██║   ██║██╔══██╗██╔═██╗     ██╔══██║██╔══██║██╔══██╗██║  ██║██╔══╝  ██╔══██╗
╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗    ██║  ██║██║  ██║██║  ██║██████╔╝███████╗██║  ██║
 ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝
 KONCOMU WES DO SUGIH]]

return {
  {
    'folke/snacks.nvim',
    lazy = false,
    priority = 1000,
    keys = {
      { '<C-p>', function() Snacks.picker.projects() end, desc = '[P]rojects' },
      { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Show [N]otifications' },
      { '<leader><space>', function() Snacks.picker.files() end, desc = 'Find files' },
      { '<leader>f', function() Snacks.explorer({ follow_file = true }) end, desc = '[F]ile Explorer' },
      { '<leader>ff', function() Snacks.picker.buffers() end, desc = 'Find Bu[ff]ers' },
      { '<leader>fg', function() Snacks.picker.git_files() end, desc = '[F]ind Current [G]it Repo' },
      { '<leader>r', function() Snacks.rename.rename_file() end, desc = '[R]ename File' },
      -- Searches
      { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch by [W]ord', mode = { 'n', 'x' } },
      { '<C-f>', function() Snacks.picker.grep() end, desc = 'Live grep' },
      -- Terminals
      { '<C-`>', function() Snacks.terminal() end, desc = 'Toggle Terminal', mode = { 'n', 't' } },
    },
    ---@module 'snacks'
    ---@type snacks.Config
    opts = function (_, opts)
      opts.dashboard = {
        preset = { header = header },
        sections = {
          { section = 'header' },
          { section = 'keys', icon = ' ', title = 'Keys', padding = 1 },
          { section = 'projects', icon = ' ', title = 'Projects', padding = 1 },
          { section = 'startup' },
        },
      }

      opts.explorer = {
        replace_netrw = true,
      }

      opts.input = {}

      opts.indent = {
        indent = { char = '┆' },
        scope = { char = '│' },
        animate = { step = 10, total = 100 },
      }

      opts.image = {
        doc = {},
      }

      opts.notifier = {}

      opts.picker = {
        layout = { preset = 'dropdown' },
        layouts = {
          sidebar = {
            layout = {
              position = 'right',
              width = 32,
            },
          },
        },
        matcher = { frecency = true },
        sources = {
          explorer = { hidden = true },
          files = { hidden = true },
        },
      }

      opts.statuscolumn = {}

      opts.terminal = {
        win = { border = 'rounded' },
      }

      opts.win = { backdrop = false }
    end,
  }
}
