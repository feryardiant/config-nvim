local php = require('custom.php')

return {
  css = {
    lint = {
      -- Do not warn for Tailwind's @apply rule
      unknownAtRules = 'ignore',
    },
  },

  lua = {
    completion = {
      callSnippet = 'Replace',
    },
    diagnostics = { disable = { 'missing-fields' } },
  },

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

  eslint = {},

  deno = {},

  js = {
    inlayHints = {
      functionLikeReturnTypes = { enabled = true },
      parameterNames = { enabled = 'literals' },
      parameterTypes = { enabled = true },
    },
  },

  ts = {
    inlayHints = {
      functionLikeReturnTypes = { enabled = true },
      parameterNames = { enabled = 'literals' },
      parameterTypes = { enabled = true },
    },
  },

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
  },

  yaml = {
    schemas = {
      ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '.gitlab-ci.yml',
      ['http://json.schemastore.org/composer'] = 'composer.yaml',
      ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yml',
      ['https://raw.githubusercontent.com/DavidAnson/markdownlint/main/schema/markdownlint-config-schema.json'] = '.markdownlint.{yml,yaml}',
      ['https://raw.githubusercontent.com/kamilkisiela/graphql-config/v3.0.3/config-schema.json'] = '.graphqlrc*',
      ['https://json.schemastore.org/github-workflow.json'] = '.github/workflow/*.yml',
    },
  },
}
