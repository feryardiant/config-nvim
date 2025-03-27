local M = {}

---@param default_opts? number|vim.keymap.set.Opts
function M.create(default_opts)
  if type(default_opts) == 'number' then
    -- It should be buffer, right?
    default_opts = { buffer = default_opts }
  end

  default_opts = default_opts or {}

  ---@param mode string|string[]
  ---@param lhs string
  ---@param rhs string|fun()
  ---@param opts? vim.keymap.set.Opts
  return function(mode, lhs, rhs, opts)
    opts = opts or {}

    if default_opts ~= nil then
      -- Assign buffer is available
      opts.buffer = default_opts.buffer
    end

    if default_opts.desc ~= nil then
      -- Add description prefix
      opts.desc = default_opts.desc .. opts.desc
    end

    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return M
