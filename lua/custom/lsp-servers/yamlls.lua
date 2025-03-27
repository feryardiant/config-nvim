---@type lspconfig.Config
return {
  settings = {
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
  },
}
