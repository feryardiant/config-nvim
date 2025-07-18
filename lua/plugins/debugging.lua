return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'jay-babu/mason-nvim-dap.nvim' },
      { 'theHamsta/nvim-dap-virtual-text' },
    },
    cmd = { 'DapContinue', 'DapToggleBreakpoint' },
    keys = {
      { '<F5>', '<cmd>DapContinue<CR>', desc = 'Debug: Start/Continue' },
      { '<leader>db', '<cmd>DapToggleBreakpoint<CR>', desc = 'Debug: Toggle Breakpoint' },
      {
        '<leader>d',
        function()
          local items = {
            'Add conditional breakpoint',
            'Add hit condition',
            'Add log point',
          }

          Snacks.picker.select(items, { prompt = 'Set Breakpoint' }, function(label, idx)
            local dap, param = require('dap'), vim.fn.input(label .. ': ')
            local cases = {
              [1] = function() dap.set_breakpoint(param, nil, nil) end,
              [2] = function() dap.set_breakpoint(nil, param, nil) end,
              [3] = function() dap.set_breakpoint(nil, nil, param) end,
            }

            cases[idx]()
          end)
        end,
        desc = 'Debug: Set Breakpoint',
      },
    },
    init = function()
      -- Credit: https://github.com/mfussenegger/nvim-dap/discussions/355
      local sings = {
        Breakpoint = '',
        BreakpointCondition = '',
        BreakpointRejected = '',
        LogPoint = '',
        Stopped = '',
      }

      for label, icon in pairs(sings) do
        label = 'Dap' .. label
        vim.fn.sign_define(label, { text = icon, texthl = label })
      end
    end,
    ---@diagnostic disable: inject-field
    config = function()
      local utils, keymap = require('utils'), require('utils.keymap')
      local dap, mason_registry = require('dap'), require('mason-registry')

      -- see https://github.com/feryardiant/config-nvim/pull/19
      local session_id = nil

      ---@param session table
      dap.listeners.before.event_initialized.dapui_config = function(session)
        local map = keymap.create()

        if session_id == nil then
          map('n', '<F1>', dap.step_into, { desc = 'Debug: Step into' })
          map('n', '<F2>', dap.step_over, { desc = 'Debug: Step over' })
          map('n', '<F3>', dap.step_out, { desc = 'Debug: Step out' })
          map('n', '<F4>', dap.step_back, { desc = 'Debug: Step back' })

          map('n', '<leader>dc', dap.clear_breakpoints, { desc = 'Debug: Clear breakpoints' })
          map('n', '<leader>dd', function()
            -- Evaluate value under the cursor
            require('dapui').eval(nil, { enter = true })
          end, { desc = 'Debug: Evaluate value' })

          -- Track in which session we set the keymaps
          session_id = session.id
        end

        session.on_close['debug.keymap'] = function(sess)
          if session_id == sess.id then
            keymap.delete('<F1>', '<F2>', '<F3>', '<F4>', '<leader>dd')

            -- Close dapui panels when only 1 session left
            package.loaded.dapui.close()

            -- Reset sessions tracker
            session_id = nil
          end
        end

        require('dapui').open()
      end

      -- PHP debug config

      if mason_registry.is_installed('php-debug-adapter') then
        dap.adapters.php = {
          type = 'executable',
          command = vim.fn.exepath('php-debug-adapter'),
        }

        local php, fs = require('utils.php'), require('utils.fs')

        for _, lang in ipairs({ 'php', 'blade' }) do
          dap.configurations[lang] = {
            {
              type = 'php',
              request = 'launch',
              name = 'DAP: Listen for XDebug',
              port = php.xdebug_port(),
              cwd = vim.fn.getcwd(),
            },
          }
        end

        if fs.file_exists('public/index.php') then
          local route_file = php.route_file()
          local dev_server = {
            type = 'php',
            request = 'launch',
            name = 'DAP: Launch Built-in Server and Debug',
            cwd = vim.fn.getcwd() .. '/public',
            port = php.xdebug_port(),
            env = {
              XDEBUG_CONFIG = 'client_host=127.0.0.1 client_port=${port}',
              XDEBUG_MODE = 'debug',
            },
            runtimeArgs = { '-dxdebug.start_with_request=yes', '-S', 'localhost:8000', '-t', '.' },
          }

          if fs.file_exists('.env') then
            -- Try to add compatibility with non-laravel project
            dev_server.envFile = '../.env'
          end

          if route_file ~= nil then
            -- Assign route file when available
            table.insert(dev_server.runtimeArgs, '../' .. route_file)
          end

          table.insert(dap.configurations.php, dev_server)
        end
      end

      -- Front-end debug config (JS(X), TS(X), Vue, Svelte, Astro)

      local js_langs = {
        'javascript',
        'typescript',
      }

      local fe_langs = {
        'astro',
        'javascriptreact',
        'svelte',
        'typescriptreact',
        'vue',
      }

      table.move(js_langs, 1, #js_langs, #fe_langs, fe_langs)

      for _, lang in ipairs(fe_langs) do
        dap.configurations[lang] = dap.configurations[lang] or {}
      end

      if mason_registry.is_installed('js-debug-adapter') then
        for _, adapter in ipairs({ 'node', 'chrome', 'msedge' }) do
          dap.adapters[adapter] = {
            type = 'executable',
            command = vim.fn.exepath('js-debug-adapter'),
          }

          -- dap.adapters[adapter] = {
          --   type = 'server',
          --   host = 'localhost',
          --   port = '${port}',
          --   executable = {
          --     command = 'node',
          --     args = {
          --       vim.fn.expand('$MASON/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'),
          --       '${port}',
          --     },
          --   },
          -- }

          dap.adapters['pwa-' .. adapter] = function(cb, config)
            local native_adapter = dap.adapters[adapter]

            config.type = adapter

            if type(native_adapter) == 'function' then
              native_adapter(cb, config)
            else
              cb(native_adapter)
            end
          end
        end

        for _, lang in ipairs(js_langs) do
          local launchFile = {
            type = 'node',
            request = 'launch',
            name = 'DAP: Launch file using Node.js',
            program = '${file}',
            cwd = '${workspaceFolder}',
          }

          if lang == 'typescript' then
            -- Try to run current script with `ts-node`
            launchFile.name = launchFile.name .. ' with ts-node'
            launchFile.runtimeArgs = { '-r', 'ts-node/register' }
          end

          table.insert(dap.configurations[lang], launchFile)

          table.insert(dap.configurations[lang], {
            type = 'node',
            request = 'launch',
            name = 'DAP: Attach to Node.js Process',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          })
        end

        for _, lang in ipairs(fe_langs) do
          table.insert(dap.configurations[lang], {
            type = 'chrome',
            request = 'launch',
            name = 'DAP: Launch Chrome',
            url = utils.launch_url_prompt,
            webroot = '${workspacefolder}',
            sourcemaps = true,
          })

          table.insert(dap.configurations[lang], {
            type = 'msedge',
            request = 'launch',
            name = 'DAP: Launch MSEdge',
            url = utils.launch_url_prompt,
            webRoot = '${workspaceFolder}',
            sourceMaps = true,
          })
        end
      end

      if mason_registry.is_installed('firefox-debug-adapter') then
        dap.adapters.firefox = {
          type = 'executable',
          command = vim.fn.exepath('firefox-debug-adapter'),
        }

        for _, lang in ipairs(fe_langs) do
          table.insert(dap.configurations[lang], {
            type = 'firefox',
            request = 'launch',
            name = 'DAP: Launch Firefox',
            url = utils.launch_url_prompt,
            webRoot = '${workspaceFolder}',
            sourceMaps = true,
            firefoxExecutable = vim.fn.exepath('firefox'),
          })
        end
      end
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      { 'mfussenegger/nvim-dap' },
      { 'nvim-neotest/nvim-nio' },
    },
    keys = {
      { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
    },
    ---@module 'dapui'
    ---@type dapui.Config
    opts = {
      controls = { element = 'watches' },
      floating = { border = 'rounded' },
      layouts = {
        {
          size = 32,
          position = 'right',
          elements = {
            { size = 0.3, id = 'scopes' },
            { size = 0.3, id = 'stacks' },
            { size = 0.2, id = 'breakpoints' },
            { size = 0.2, id = 'watches' },
          },
        },
        {
          size = 10,
          position = 'bottom',
          elements = {
            { size = 0.6, id = 'repl' },
            { size = 0.4, id = 'console' },
          },
        },
      },
    },
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    lazy = true,
    dependencies = {
      { 'williamboman/mason.nvim' },
    },
    ---@module 'mason-nvim-dap'
    ---@type MasonNvimDapSettings
    opts = {
      automatic_installation = true,
      ensure_installed = {
        'firefox',
        'js',
        'php',
      },
    },
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    lazy = true,
    ---@module 'nvim-dap-virtual-text'
    ---@type nvim_dap_virtual_text_options
    opts = {
      display_callback = function(var, _, _, _, opts)
        local name = var.name:lower()
        local value = var.value:lower()
        local output = var.value:gsub('%s+', ' ')

        if name:match('secret') or name:match('key') or name:match('api') then
          output = '****'
        elseif output:find('\\') ~= nil then
          output = '…\\' .. require('custom.php').class_basename(output)
        elseif #value > 10 then
          output = output:sub(1, 10) .. '…'
        end

        if opts.virt_text_pos == 'inline' then
          -- Print the output
          return '→ ' .. output
        end

        return string.format('%s→ %s', var.name, output)
      end,
    },
  },
}
