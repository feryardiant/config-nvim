return {
  {
      'norcalli/nvim-colorizer.lua',
      event = { 'BufReadPre', 'BufNewFile' },
      opts = { '*' },
    },

    {
      'laytan/cloak.nvim',
      ft = 'dotenv',
      ---@module 'cloak'
      opts = {
        patterns = {
          {
            file_pattern = '.env*',
            cloak_pattern = {
              '(%u+_ID)=.+',
              '(%u+_DSN)=.+',
              '(%u+_KEY)=.+',
              '(%u+_PASS%u+)=.+',
              '(%u+_PRIVATE%u+)=.+',
              '(%u+_SECRET%u+)=.+',
              '(%u+_TOKEN%u+)=.+',
              '(%u+_USER%u+)=.+',
              '(%u+)=(%a+://).+',
              '(%u+)=[\'"](%a+://).+[\'"]$',
            },
            replace = '%1=',
          },
        },
      },
    },
}
