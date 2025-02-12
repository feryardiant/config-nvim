local util = {}

---@param default_opts? number|vim.keymap.set.Opts
function util.create_keymap(default_opts)
  if type(default_opts) == 'number' then
    -- If its not a table it must be a buffer
    default_opts = { buffer = default_opts }
  end

  default_opts = default_opts or {}

  ---@param mode string|string[]
  ---@param lhs string
  ---@param rhs string|fun()
  ---@param opts? vim.keymap.set.Opts
  return function(mode, lhs, rhs, opts)
    opts = opts or {}

    if default_opts.buffer ~= nil then
      -- Assign buffer if available
      opts.buffer = default_opts.buffer
    end

    if default_opts.desc ~= nil then
      -- Add description prefix if available
      opts.desc = default_opts.desc .. opts.desc
    end

    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

---@param file string
---@return boolean
function util.is_image(file)
  local extensions = { 'jpg', 'jpeg', 'png' }
  local splits = vim.split(file:lower(), '.', { plain = true })
  local extension = splits[#splits]

  return vim.tbl_contains(extensions, extension)
end

return util
