return {
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    ---@module 'trouble'
    ---@type trouble.Config
    opts = {
      use_diagnostic_signs = true,
    },
    init = function()
      local map = require('utils.keymap').create()
      local sings = {
        Error = ' ',
        Warn = ' ',
        Info = ' ',
        Hint = '󰌵 ',
      }

      for label, icon in pairs(sings) do
        label = 'DiagnosticSign' .. label
        vim.fn.sign_define(label, { text = icon, texthl = label })
      end

      -- Diagnostics
      local diagnostic_goto = function(next, severity)
        local go = next and vim.diagnostic.get_next or vim.diagnostic.get_prev
        severity = severity and vim.diagnostic.severity[severity] or nil

        return function()
          vim.diagnostic.jump({
            diagnostic = go(),
            severity = severity,
          })
        end
      end

      -- map('n', '[d', diagnostic_goto(false), { desc = 'Prev [D]iagnostic' })
      -- map('n', ']d', diagnostic_goto(true), { desc = 'Next [D]iagnostic' })
      map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev [E]rror' })
      map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next [E]rror' })
      map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev [W]arning' })
      map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next [W]arning' })

      map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    end,
  },
}
