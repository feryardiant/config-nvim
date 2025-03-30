return {
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    init = function()
      local map = require('utils.keymap').create()

      -- Diagnostics
      local diagnostic_jump = function(next, severity)
        local go = next and vim.diagnostic.get_next or vim.diagnostic.get_prev
        severity = severity and vim.diagnostic.severity[severity] or nil

        return function()
          vim.diagnostic.jump({
            diagnostic = go(),
            severity = severity,
          })
        end
      end

      map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      map('n', '<leader>ea', function() Snacks.picker.diagnostics() end, { desc = 'Open [D]iagnostics' } )
      map('n', '<leader>ee', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Open [D]iagnostics Buffer' } )

      map('n', '[e', diagnostic_jump(false, 'ERROR'), { desc = 'Prev [E]rror' })
      map('n', ']e', diagnostic_jump(true, 'ERROR'), { desc = 'Next [E]rror' })
      map('n', '[w', diagnostic_jump(false, 'WARN'), { desc = 'Prev [W]arning' })
      map('n', ']w', diagnostic_jump(true, 'WARN'), { desc = 'Next [W]arning' })
    end,
    ---@module 'trouble'
    ---@type trouble.Config
    opts = {
      use_diagnostic_signs = true,
    },
  },
}
