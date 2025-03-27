---@class fs
local FS = {}
local uv = vim.uv or vim.loop

---Check whether file exists
---@param ... string
---@return boolean
function FS.file_exists(...)
  for _, filepath in ipairs({ ... }) do
    filepath = table.concat({ vim.fn.getcwd(), filepath }, '/')

    if uv.fs_stat(filepath) ~= nil then return true end
  end

  return false
end

return FS
