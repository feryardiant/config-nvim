local php = require('utils.php')

---@type lspconfig.Config
return {
  filetypes = { 'blade', 'php_only' },
  settings = {
    intelephense = {
      environment = {
        includePaths = php.include_paths(),
      },
      files = {
        maxSize = 5000000,
        exclude = {
          '**/*.old',
          '**/*.old/**',
          '**/.git/**',
          '**/.svn/**',
          '**/.hg/**',
          '**/CVS/**',
          '**/.DS_Store/**',
          '**/node_modules/**',
          '**/bower_components/**',
          '**/vendor/**/{Tests,tests}/**',
          '**/.history/**',
          '**/vendor/**/vendor/**',
        },
      },
      references = {
        exclude = {
          '**/*.old/**',
          '**/vendor/**',
        },
      },
      stubs = php.collect_stubs()
    },
  },
}
