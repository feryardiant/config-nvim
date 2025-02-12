return {
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonUpdate' },
    ---@module 'mason'
    ---@type MasonSettings
    opts = {
      ui = {
        border = 'rounded',
        width = 0.8,
        height = 0.7,
        icons = {
          package_installed = '✓',
          package_uninstalled = '✗',
        },
      },
    },
  },

  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    ---@module 'mason-lspconfig'
    ---@param opts MasonLspconfigSettings
    opts = function(_, opts)
      local settings = require('settings')
      local mason_registry = require('mason-registry')

      ---Retrieve mason package install path
      ---@param package_name string
      ---@return string
      local function get_mason_pkg_path(package_name) return mason_registry.get_package(package_name):get_install_path() end

      ---@type table<string, lspconfig.Config>
      local servers = {
        cssls = {
          filetypes = { 'css', 'less', 'sass', 'scss', 'pcss', 'postcss' },
          settings = { css = settings.css },
        },
        jsonls = {
          settings = { json = settings.json },
        },
        yamlls = {
          settings = { yaml = settings.yaml },
        },
        emmet_ls = {
          filetypes = { 'blade', 'gohtml', 'gohtmltmpl', 'handlebars', 'hbs', 'njk', 'nunjucks', 'templ' },
        },
        html = {
          filetypes = { 'blade' },
        },
        intelephense = {
          filetypes = { 'blade', 'php_only' },
          settings = { intelephense = settings.intelephense },
        },
        lua_ls = {
          settings = { Lua = settings.lua },
        },
      }

      local lspconfig = require('lspconfig')
      local ensure_installed = vim.tbl_keys(servers or {})

      opts.ensure_installed = vim.list_extend(ensure_installed, {
        'bashls',
        'dockerls',
        'eslint',
        'nginx_language_server',
        'sqls',
        'svelte',
        'tailwindcss',
        'ts_ls',
        'unocss',
        'vimls',
        'volar',
      })

      opts.handlers = {
        -- Default handler for all available LSP server.
        ---@param server string
        function(server)
          ---@type lspconfig.Config
          local config = servers[server] or {}
          local ok, base_config = pcall(require, 'lspconfig.configs.' .. server)

          if ok then
            local default_config = base_config.default_config or {}
            config.filetypes = vim.list_extend(default_config.filetypes, config.filetypes or {})

            table.sort(config.filetypes, function(a, b) return a:upper() < b:upper() end)
          end

          local capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
          )

          config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})

          lspconfig[server].setup(config)
        end,
      }

      ---@param server string
      opts.handlers.ts_ls = function(server)
        servers[server] = {
          filetypes = {},
          init_options = { plugins = {} },
          settings = {
            javascript = settings.js,
            typescript = settings.ts,
          },
        }

        -- Add Vue Typescript supports
        ---@see https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vue-support
        if mason_registry.is_installed('vue-language-server') then
          local plugin = {
            name = '@vue/typescript-plugin',
            languages = { 'vue', 'javascript', 'typescript' },
            location = table.concat({
              get_mason_pkg_path('vue-language-server'),
              'node_modules/@vue/language-server',
              'node_modules/@vue/typescript-plugin',
            }, '/'),
          }

          servers[server].settings.tsserver_plugins = { plugin.name }

          table.insert(servers[server].filetypes, 'vue')
          table.insert(servers[server].init_options.plugins, plugin)
        end

        -- Pass it back to default handler
        opts.handlers[1](server)
      end
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
          ---@param opts vim.keymap.set.Opts
          ---@param mode? string|string[]
          local function map(keys, func, opts, mode)
            mode = mode or 'n'
            opts = opts or {}

            opts.buffer = event.buf
            opts.remap = false
            opts.desc = 'LSP: ' .. opts.desc

            vim.keymap.set(mode, keys, func, opts)
          end

          map('gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
          map('gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })

          map('gr', vim.lsp.buf.references, { desc = '[G]oto [R]eferences' })
          map('gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })

          map('<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
          map('<leader>ds', telescope_builtin.lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })

          map('<leader>ws', telescope_builtin.lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })

          map('<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
          map('<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' }, { 'n', 'x' })

          map('K', vim.lsp.buf.hover, { desc = 'Show signature help' })

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if not client then return end

          -- Credit: https://github.com/nvim-lua/kickstart.nvim/blob/7201dc480134f41dd1be1f8f9b8f8470aac82a3b/init.lua#L555-L588
          if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })

            vim.api.nvim_create_autocmd('CursorHold', {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd('CursorMoved', {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(e)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'lsp_document_highlight', buffer = e.buf })
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
              { desc = '[T]oggle Inlay [H]ints' }
            )
          end
        end,
      })
    end,
  },
}
