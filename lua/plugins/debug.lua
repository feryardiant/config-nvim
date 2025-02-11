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

      vim.keymap.set({ 'n' }, '<F1>', dap.step_into, { desc = 'Debug: Step into' })
      vim.keymap.set({ 'n' }, '<F2>', dap.step_over, { desc = 'Debug: Step over' })
      vim.keymap.set({ 'n' }, '<F3>', dap.step_out, { desc = 'Debug: Step out' })
      vim.keymap.set({ 'n' }, '<F4>', dap.step_back, { desc = 'Debug: Step back' })

      vim.keymap.set(
        { 'n' },
        '<leader>?',
        function() dapui.eval(nil, { enter = true }) end,
        { desc = 'Debug: Evaluate value under the cursor' }
      )

      local mason_registry = require('mason-registry')

      local enter_launch_url = function()
        local co = coroutine.running()

        return coroutine.create(function()
          vim.ui.input({ prompt = 'Enter URL: ', default = 'http://localhost:' }, function(url)
            if url == nil or url == '' then
              return
            else
              coroutine.resume(co, url)
            end
          end)
        end)
      end

      -- PHP debug config

      if mason_registry.is_installed('php-debug-adapter') then
        dap.adapters.php = {
          type = 'executable',
          command = vim.fn.exepath('php-debug-adapter'),
        }

        local php = require('custom.php')
        local xdebug_port = 9003

        for _, lang in ipairs({ 'php', 'blade' }) do
          dap.configurations[lang] = {
            {
              type = 'php',
              request = 'launch',
              name = 'DAP: Listen for XDebug',
              port = xdebug_port,
              cwd = vim.fn.getcwd(),
            },
          }
        end

        if php.file_exists('/public/index.php') then
          local route_file = php.route_file()
          local dev_server = {
            type = 'php',
            request = 'launch',
            name = 'DAP: Launch built-in server and Debug',
            cwd = vim.fn.getcwd()..'/public',
            port = xdebug_port,
            runtimeArgs = {
              '-dxdebug.client_host=127.0.0.1',
              '-dxdebug.client_port='..xdebug_port,
              '-dxdebug.mode=debug',
              '-dxdebug.start_with_request=yes',
              '-S',
              'localhost:8000',
              '-t',
              '.'
            },
          }

          if php.file_exists('/.env') then
            -- Try to add compatibility with non-laravel project
            dev_server.envFile = '../.env'
          end

          if route_file ~= nil then
            -- Assign route file when available
            table.insert(dev_server.runtimeArgs, '../'..route_file)
          end

          table.insert(dap.configurations.php, dev_server)
        end
      end

      -- Front-end debug config (JS(X), TS(X), Vue, Svelte, Astro)

      local fe_langs = {
        'astro',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'svelte',
        'vue',
      }

      for _, lang in ipairs(fe_langs) do
        dap.configurations[lang] = dap.configurations[lang] or {}
      end

      if mason_registry.is_installed('js-debug-adapter') then
        local js_adapter_path = mason_registry.get_package('js-debug-adapter'):get_install_path()

        for _, adapter in ipairs({ 'node', 'chrome', 'msedge' }) do
          local pwa_adapter = 'pwa-' .. adapter

          dap.adapters[pwa_adapter] = {
            type = 'server',
            host = 'localhost',
            port = '${port}',
            executable = {
              command = 'node',
              args = {
                js_adapter_path .. '/js-debug/src/dapDebugServer.js',
                '${port}',
              },
            },
          }

          dap.adapters[adapter] = function(cb, config)
            local native_adapter = dap.adapters[pwa_adapter]

            config.type = pwa_adapter

            if type(native_adapter) == 'function' then
              native_adapter(cb, config)
            else
              cb(native_adapter)
            end
          end
        end

        for _, lang in ipairs(fe_langs) do
          table.insert(dap.configurations[lang], {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'DAP: Launch Chrome',
            url = enter_launch_url,
            webRoot = '${workspaceFolder}',
            sourceMaps = true,
          })

          table.insert(dap.configurations[lang], {
            type = 'pwa-msedge',
            request = 'launch',
            name = 'DAP: Launch MSEdge',
            url = enter_launch_url,
            webRoot = '${workspaceFolder}',
            sourceMaps = true,
          })
        end
      end
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
}
