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
      { '<C-`>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
      { '<C-p>', function() Snacks.picker.projects() end, desc = '[P]rojects' },
      { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Show [N]otifications' },
      { '<leader><space>', function() Snacks.picker.files() end, desc = 'Find files' },
      { '<leader>f', function() Snacks.explorer({ follow_file = true }) end, desc = '[F]ile Explorer' },
      { '<leader>ff', function() Snacks.picker.buffers() end, desc = 'Find Bu[ff]ers' },
      { '<leader>fg', function() Snacks.picker.git_files() end, desc = '[F]ind Current [G]it Repo' },
      { '<leader>r', function() Snacks.rename.rename_file() end, desc = '[R]ename File' },
      -- Diagnostics
      { '<leader>d', function() Snacks.picker.diagnostics() end, desc = 'Open [D]iagnostics' },
      { '<leader>da', function() Snacks.picker.diagnostics_buffer() end, desc = 'Open [D]iagnostics Buffer' },
      -- Searches
      { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch by [W]ord', mode = { 'n', 'x' } },
      { '<C-f>', function() Snacks.picker.grep() end, desc = 'Live grep' },
      -- Git
      { '<leader>gg', function() Snacks.lazygit({ win = { border = 'rounded' } }) end, desc = 'Open LazyGit' },
      { '<leader>gl', function() Snacks.picker.git_log({ layout = 'default' }) end, desc = 'Open [G]it [L]og' },
      -- LSP
      { 'gd', function() Snacks.picker.lsp_definitions() end, desc = '[G]oto [D]efinition' },
      { 'gD', function() Snacks.picker.lsp_declarations() end, desc = '[G]oto [D]eclaration' },
      { 'gr', function() Snacks.picker.lsp_references() end, desc = '[G]oto [R]eferences', nowait = true },
      { 'gI', function() Snacks.picker.lsp_implementations() end, desc = '[G]oto [I]mplementation' },
      { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = '[G]oto T[y]pe Definition' },
      { '<leader>s', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'Workspace Symbols' },
      { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'Document Symbols' },
    },
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      dashboard = {
        preset = { header = header },
        sections = {
          { section = 'header' },
          { section = 'keys', icon = ' ', title = 'Keys', padding = 1 },
          { section = 'projects', icon = ' ', title = 'Projects', padding = 1 },
          { section = 'startup' },
        },
      },
      explorer = {
        replace_netrw = true,
      },
      input = {},
      indent = {
        indent = { char = '┆' },
        scope = { char = '│' },
        animate = { step = 10, total = 100 },
      },
      image = {
        doc = {},
      },
      notifier = {},
      picker = {
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
      },
      statuscolumn = {},
      terminal = {},
      win = { backdrop = false },
    },
    init = function()
      vim.api.nvim_create_autocmd('BufWinEnter', {
        callback = function()
          local ft = vim.bo.ft

          if ft == 'dap-repl' or ft:match('^dapui_') then
            -- Disable status column on DAP windows
            vim.wo.statuscolumn = ''
          end
        end,
      })
    end,
  },
}
