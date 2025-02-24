local util = {}
local uv = vim.uv or vim.loop

---Check whether file exists
---@param ... string
---@return boolean
function util.file_exists(...)
  for _, filepath in ipairs({ ... }) do
    filepath = table.concat({ vim.fn.getcwd(), filepath }, '/')

    if uv.fs_stat(filepath) ~= nil then return true end
  end

  return false
end

---Is it a Deno project
---@return boolean
function util.is_deno() return util.file_exists('deno.json', 'deno.jsonc', 'deno.lock') end

---Prompt user regarding the launch url.
function util.launch_url_prompt()
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

return util
