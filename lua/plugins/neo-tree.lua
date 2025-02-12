return {
  {
    '3rd/image.nvim',
    -- build = false,
    lazy = true,
    opts = {
      -- processor = 'magick_cli'
    },
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    deactivate = function() vim.cmd([[Neotree close]]) end,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'MunifTanjim/nui.nvim' },
      { '3rd/image.nvim' },
    },
    keys = {
      {
        '<leader>ge',
        function()
          require('neo-tree.command').execute({
            source = 'git_status',
            position = 'float',
            toggle = true,
          })
        end,
        desc = 'Git explorer',
      },

      {
        '<leader>be',
        function()
          require('neo-tree.command').execute({
            source = 'buffers',
            position = 'float',
            toggle = true,
          })
        end,
        desc = 'Buffers explorer',
      },

      {
        '<leader>fe',
        function()
          require('neo-tree.command').execute({
            source = 'filesystem',
            position = 'right',
            reveal = true,
            toggle = true,
          })
        end,
        desc = 'File explorer',
      },
    },
    opts = function (_, opts)
      opts.close_if_last_window = true
      opts.popup_border_style = 'rounded'

      opts.default_component_configs = {
        indent = { with_expanders = true },
        created = { enabled = true },
        symlink_target = { enabled = true },
      }

      opts.source_selector = {
        statusline = true,
        content_layout = 'center',
      }

      opts.window = {
        position = 'current',
        width = 32,
        mappings = {
          ['P'] = {
            'toggle_preview',
            config = { use_image_nvim = true }
          }
        }
      }

      opts.filesystem = {
        follow_current_file = {
          enabled = true,
        },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            'node_modules',
            'vendor',
          },
          hide_by_pattern = {
            '*.old',
            '._*',
          },
          never_show = {
            '.DS_Store',
            '.directory',
            '.git',
            'Desktop.ini',
            'thumbs.db',
          },
          never_show_by_pattern = {
            '*~',
            '*.bin',
            '*.exe',
            '*.out',
            '*.swp',
          },
        },
        use_libuv_file_watcher = true,
      }
    end,
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      if vim.fn.argc(-1) == 1 then
        ---@diagnostic disable-next-line: param-type-mismatch
        local stat = vim.uv.fs_stat(vim.fn.argv(0))
        if stat and stat.type == 'directory' then require('neo-tree') end
      end

      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.source.git_status'] then require('neo-tree.source.git_status').refresh() end
        end,
      })
    end,
  },
}
