---@type lspconfig.Config
return {
  filetypes = { 'css', 'less', 'sass', 'scss', 'pcss', 'postcss' },
  settings = {
    css = {
      lint = {
        -- Do not warn for Tailwind's @apply rule
        unknownAtRules = 'ignore',
      },
    },
  },
}
