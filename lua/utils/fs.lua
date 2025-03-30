local fs = {}
local uv = vim.uv or vim.loop

---Check whether file exists
---@param ... string
---@return boolean
function fs.file_exists(...)
  for _, filepath in ipairs({ ... }) do
    filepath = table.concat({ vim.fn.getcwd(), filepath }, '/')

    if uv.fs_stat(filepath) ~= nil then return true end
  end

  return false
end

return fs
