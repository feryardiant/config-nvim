vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'

local diagnostic_signs = { text = {}, linehl = {} }
local sings = {
  [vim.diagnostic.severity.ERROR] = { label = 'Error', icon = ' ' },
  [vim.diagnostic.severity.WARN] = { label = 'Warn', icon = ' ' },
  [vim.diagnostic.severity.INFO] = { label = 'Info', icon = ' ' },
  [vim.diagnostic.severity.HINT] = { label = 'Hint', icon = '󰌵 ' },
}

for severity, sign in pairs(sings) do
  diagnostic_signs.text[severity] = sign.icon
  diagnostic_signs.linehl[severity] = 'DiagnosticSign' .. sign.label
end

vim.diagnostic.config({ signs = diagnostic_signs })

vim.opt.confirm = true -- Confirm before exit if file has changed
vim.opt.hidden = false -- Close the buffer when tab is closed
vim.opt.wrap = false -- Do not wrap lines

vim.opt.fileformats = 'unix,dos,mac' -- Use Unix as the standard file type
vim.opt.colorcolumn = '80,100,120'
vim.opt.signcolumn = 'yes'

vim.opt.number = true -- Enable line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight line under the cursor

vim.opt.formatoptions = {
  c = true, -- Format comments
  r = true, -- Continue comments by default
  o = true, -- Make comment when using o or O from comment line
  q = true, -- Format comments with gq
  n = true, -- Recognize numbered lists
  l = true, -- Don't break lines that are already long
}

vim.opt.updatetime = 50
vim.opt.report = 0 -- Show all command reports
vim.opt.showmode = false -- Hide the current mode

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Auto/Smart/Copy indent from last line when starting new line
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.copyindent = true

-- Search
vim.opt.hlsearch = true -- Highlight searches
vim.opt.incsearch = true -- Highlight dynamically as pattern is typed
vim.opt.ignorecase = true -- Ignore case of searches
vim.opt.smartcase = true -- Ignore 'ignorecase' if search patter contains uppercase characters
vim.opt.wrapscan = true -- Searches wrap around end of file

-- Window splitting
vim.opt.splitbelow = true -- New window goes below
vim.opt.splitright = true -- New windows goes right

-- Whitespace characters
vim.opt.list = true
vim.opt.listchars = 'tab:→ ,trail:·,extends:…,precedes:…'
vim.opt.conceallevel = 3
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = '⸱',
  -- fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

vim.opt.suffixes = {
  '~',
  '.bak',
  '.bin',
  '.cache',
  '.dll',
  '.dmg',
  '.exe',
  '.min.js',
  '.o',
  '.obj',
  '.swp',
  '.swo',
}

vim.opt.wildignore = {
  '*.old/*',
  '*/vendor/*',
  '*/node_modules/*',
  '*/.DS_Store',
  '*/.git/*',
  '*/.pnpm-store/*',
  '*/.sass-cache/*',
}
