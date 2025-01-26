return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      { 'mfussenegger/nvim-dap' },
      { 'nvim-neotest/nvim-nio' },
      { 'stevearc/dressing.nvim' },
      { 'jay-babu/mason-nvim-dap.nvim' },
    },
    keys = {
      { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
    },
    ---@module 'dapui'
    ---@type dapui.Config
    opts = {},
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'theHamsta/nvim-dap-virtual-text' },
    },
    keys = {
      { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
      { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step into' },
      { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step over' },
      { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step out' },
      { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    },
    init = function()
      -- Credit: https://github.com/mfussenegger/nvim-dap/discussions/355
      vim.fn.sign_define('DapBreakpoint', { text = '󰃤', texthl = 'DapBreakpoint' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '󰃤', texthl = 'DapBreakpointCondition' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '󰃤', texthl = 'DapBreakpointRejected' })
      vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint' })
      vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped' })
    end,
    config = function()
      local dap, dapui = require('dap'), require('dapui')

      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    lazy = true,
    ---@module 'nvim-dap-virtual-text'
    ---@type nvim_dap_virtual_text_options
    opts = {
      display_callback = function(var)
        local name = string.lower(var.name)
        local value = string.lower(var.value)

        if name:match('secret') or name:match('key') or name:match('api') then return '*****' end

        if #value > 10 then return ' ' .. string.sub(var.value, 1, 10) .. '...' end

        return var.value
      end,
    },
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    lazy = true,
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'mfussenegger/nvim-dap' },
    },
    opts = {
      automatic_installation = true,
      ensure_installed = {
        'chrome-debug-adapter',
        'firefox-debug-adapter',
        'php-debug-adapter',
        'js-debug-adapter',
        'node-debug2-adapter',
      },
      handlers = {
        -- all sources with no handler get passed here
        -- see https://github.com/jay-babu/mason-nvim-dap.nvim?tab=readme-ov-file#advanced-customization
        function(config) require('mason-nvim-dap').default_setup(config) end,

        -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#php
        ---@param config table
        php = function(config)
          config.adapters = {
            type = 'executable',
            command = 'php-debug-adapter',
          }

          -- Overwrite default config
          ---@see https://github.com/jay-babu/mason-nvim-dap.nvim/blob/8b9363d/lua/mason-nvim-dap/mappings/configurations.lua#L135-L140
          config.configurations[1].port = 9003
          config.configurations[1].cwd = '${workspaceFolder}'

          require('mason-nvim-dap').default_setup(config)
        end,
      },
    },
  },
}
