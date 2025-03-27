---@type lspconfig.Config
return {
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { 'composer.json' },
          url = 'https://getcomposer.org/schema.json',
        },
        {
          fileMatch = { 'jsconfig.json' },
          url = 'https://json.schemastore.org/jsconfig',
        },
        {
          fileMatch = { 'tsconfig.json' },
          url = 'https://json.schemastore.org/tsconfig',
        },
        {
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package',
        },
        {
          fileMatch = { '.markdownlint.json', '.markdownlint.jsonc' },
          url = 'https://raw.githubusercontent.com/DavidAnson/markdownlint/main/schema/markdownlint-config-schema.json',
        },
        {
          fileMatch = { '.prettierrc.json', '.prettierrc' },
          url = 'https://json.schemastore.org/prettierrc.json',
        },
        {
          fileMatch = { '.eslintrc.json' },
          url = 'https://json.schemastore.org/eslintrc.json',
        },
      },
    }
  }
}
