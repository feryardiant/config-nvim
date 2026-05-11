---@type lspconfig.Config
return {
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { '.gemini/settings.json', 'gemini/settings.json' },
          url = 'https://raw.githubusercontent.com/google-gemini/gemini-cli/main/schemas/settings.schema.json',
        },
        {
        fileMatch = { '.devcontainer/*/devcontainer.json', '.devcontainer/devcontainer.json', '.devcontainer.json' },
          url = 'https://raw.githubusercontent.com/devcontainers/spec/refs/heads/main/schemas/devContainer.base.schema.json',
        },
        {
          fileMatch = { 'composer.json' },
          url = 'https://getcomposer.org/schema.json',
        },
        {
          fileMatch = { 'deno.json', 'deno.jsonc' },
          url = 'https://raw.githubusercontent.com/denoland/deno/refs/heads/main/cli/schemas/config-file.v1.json',
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
    },
  },
}
