return {
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonUpdate' },
  },

  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    opts = function()
      local capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
      )

      local settings = require('settings')
      local servers = {
        cssls = {
          settings = { css = settings.css },
        },
        jsonls = {
          settings = { json = settings.json },
        },
        yamlls = {
          settings = { yaml = settings.yaml },
        },
        intelephense = {
          settings = { intelephense = settings.intelephense },
        },
        lua_ls = {
          settings = { Lua = settings.lua },
        },
      }

      local lspconfig = require('lspconfig')
      local ensure_installed = vim.tbl_keys(servers or {})

      ---Retrieve mason package install path
      ---@param package_name string
      ---@return string
      local function get_mason_pkg_path(package_name)
        return require('mason-registry').get_package(package_name):get_install_path()
      end

      vim.list_extend(ensure_installed, {
        'nginx_language_server',
        'emmet_ls',
        'dockerls',
        'sqls',
        'html',
        'tailwindcss',
        'eslint',
        'ts_ls',
        'svelte',
        'volar',
      })

      return {
        ensure_installed = ensure_installed,
        handlers = {
          function(server_name)
            local config = servers[server_name] or {}

            if server_name == 'tsserver' then server_name = 'ts_ls' end

            if server_name == 'emmet_ls' then
              config.filetypes = {
                'astro',
                'blade',
                'css',
                'eruby',
                'html',
                'htmlangular',
                'htmldjango',
                'javascriptreact',
                'less',
                'pug',
                'sass',
                'scss',
                'svelte',
                'typescriptreact',
                'vue',
              }
            end

            if server_name == 'intelephense' then config.filetypes = { 'blade', 'php', 'php_only' } end

            if server_name == 'html' then config.filetypes = { 'blade', 'html', 'templ' } end

            config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})

            lspconfig[server_name].setup(config)
          end,

          ts_ls = function()
            lspconfig.ts_ls.setup({
              capabilities = capabilities,
              filetypes = {
                'javascript',
                'javascriptreact',
                'javascript.jsx',
                'typescript',
                'typescriptreact',
                'typescript.tsx',
                'vue',
              },
              init_options = {
                plugins = {
                  {
                    name = '@vue/typescript-plugin',
                    location = table.concat({
                      get_mason_pkg_path('vue-language-server'),
                      'node_modules/@vue/language-server',
                      'node_modules/@vue/typescript-plugin',
                    }, '/'),
                    languages = { 'vue', 'javascript', 'typescript' },
                  },
                },
              },
              settings = {
                tsserver_plugins = {
                  '@vue/typescript-plugin',
                },
              },
            })
          end,

          volar = function()
            local global_ts_path = table.concat({
              get_mason_pkg_path('typescript-language-server'),
              'node_modules/typescript/lib',
            }, '/')

            ---Get typescript server path
            ---@param root_path string
            ---@return string
            local function get_ts_path(root_path)
              -- credit : https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#volar
              local project_ts_path = ''

              ---Check typescript server lib directory
              ---@param project_path string
              ---@return string?
              local function check_ts_dir(project_path)
                project_ts_path = project_path .. '/node_modules/typescript/lib'

                if vim.loop.fs_stat(project_ts_path) then return project_path end
              end

              if lspconfig.util.search_ancestors(root_path, check_ts_dir) then
                return project_ts_path
              else
                return global_ts_path
              end
            end

            lspconfig.volar.setup({
              capabilities = capabilities,
              init_options = {
                typescript = {
                  tsdk = global_ts_path,
                },
              },
              on_new_config = function(new_config, root_path)
                new_config.init_options.typescript.tsdk = get_ts_path(root_path)
              end,
            })
          end,
        },
      }
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-cmp' },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local telescope_builtin = require('telescope.builtin')

          ---@param keys string
          ---@param func function
          ---@param desc string
          ---@param mode? table|string
          local function map(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc, remap = false })
          end

          map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
          map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

          map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
          map('<leader>ds', telescope_builtin.lsp_document_symbols, '[D]ocument [S]ymbols')

          map('<leader>ws', telescope_builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          map('K', vim.lsp.buf.hover, 'Show signature help')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Credit: https://github.com/nvim-lua/kickstart.nvim/blob/7201dc480134f41dd1be1f8f9b8f8470aac82a3b/init.lua#L555-L588
          if client then
            if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
              local highlight_augroup = vim.api.nvim_create_augroup('my-lsp-highlight', { clear = false })

              vim.api.nvim_create_autocmd({ 'CursorHold' }, {
                buffer = event.buff,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
                buffer = event.buff,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

              vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                callback = function(e)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds({ group = 'my-lsp-highlight', buffer = e.buf })
                end,
              })
            end

            if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
              map(
                '<leader>th',
                function()
                  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({
                    bufnr = event.buf,
                  }))
                end,
                '[T]oggle Inlay [H]ints'
              )
            end
          end
        end,
      })
    end,
  },
}
