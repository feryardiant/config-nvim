# My personal NeoVim config

## Installation

1. Clone this repo to your `~/.config/nvim`
2. Run the following command to install all the plugins in headless mode

   ```sh
   nvim --headless '+Lazy! sync' +qa
   ```

3. Open any file using `nvim` for the first time to initiate `treesitter` and `mason` plugins

4. run the following command to install additional `mason` plugins

   ```vim
   :MasonToolsInstallSync
   ```

5. You should good to go!

## Plugins

### Essentials

- [`folke/lazy.nvim`](https://github.com/folke/lazy.nvim)
- [`folke/noice.nvim`](https://github.com/folke/noice.nvim)
- [`folke/snacks.nvim`](https://github.com/folke/snacks.nvim) with the following subpackages are enabled :
  - [`Snacks.dashboard`](https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md)
  - [`Snacks.explorer`](https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md)
  - [`Snacks.input`](https://github.com/folke/snacks.nvim/blob/main/docs/input.md)
  - [`Snacks.indent`](https://github.com/folke/snacks.nvim/blob/main/docs/indent.md)
  - [`Snacks.image`](https://github.com/folke/snacks.nvim/blob/main/docs/image.md)
  - [`Snacks.notifier`](https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md)
  - [`Snacks.picker`](https://github.com/folke/snacks.nvim/blob/main/docs/picker.md)
  - [`Snacks.statuscolumn`](https://github.com/folke/snacks.nvim/blob/main/docs/statuscolumn.md)
  - [`Snacks.terminal`](https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md)
- [`folke/trouble.nvim`](https://github.com/folke/trouble.nvim)
- [`folke/which-key.nvim`](https://github.com/folke/which-key.nvim)
- [`stevearc/conform.nvim`](https://github.com/stevearc/conform.nvim)
- [`neovim/nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig)
- [`MunifTanjim/nui.nvim`](https://github.com/MunifTanjim/nui.nvim)
- [`echasnovski/mini.nvim`](https://github.com/echasnovski/mini.nvim) with the following subpackages are enabled :
  - [`mini.comment`](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md)
  - [`mini.icons`](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-icons.md)
  - [`mini.pairs`](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md)
  - [`mini.snippets`](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-snippets.md)
  - [`mini.statusline`](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-statusline.md)
  - [`mini.surround`](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md)
- [`williamboman/mason.nvim`](https://github.com/williamboman/mason.nvim)
  - [`williamboman/mason-lspconfig.nvim`](https://github.com/williamboman/mason-lspconfig.nvim)
  - [`WhoIsSethDaniel/mason-tool-installer.nvim`](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)
- [`nvim-treesitter/nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter)
  - [`nvim-treesitter/nvim-treesitter-context`](https://github.com/nvim-treesitter/nvim-treesitter-context)
  - [`nvim-treesitter/nvim-treesitter-textobjects`](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
  - [`JoosepAlviste/nvim-ts-context-commentstring`](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
  - [`windwp/nvim-ts-autotag`](https://github.com/windwp/nvim-ts-autotag)
  - [`EmranMR/tree-sitter-blade`](https://github.com/EmranMR/tree-sitter-blade)
  - [`pnx/tree-sitter-dotenv`](https://github.com/pnx/tree-sitter-dotenv)

### Extras

- [`folke/lazydev.nvim`](https://github.com/folke/lazydev.nvim)
- [`ricardoramirezr/blade-nav.nvim`](https://github.com/ricardoramirezr/blade-nav.nvim)

### Completion

- [`saghen/blink.cmp`](https://github.com/saghen/blink.cmp)
- [`saghen/blink.compat`](https://github.com/saghen/blink.compat)
- [`rafamadriz/friendly-snippets`](https://github.com/rafamadriz/friendly-snippets)

### Debugging

- [`mfussenegger/nvim-dap`](https://github.com/mfussenegger/nvim-dap) with the following debuggers pre-configured :
  - [`js-debug-adapter`](https://github.com/microsoft/vscode-js-debug) to integrate with chromium-base browsers (`chrome`, `edge`, etc) for debugging node backend and js/ts frontend
  - [`php-debug-adapter`](https://github.com/xdebug/vscode-php-debug) to integrate with `ext-xdebug`
  - [`firefox-debug-adapter`](https://github.com/firefox-devtools/vscode-firefox-debug) to debug js/ts frontend using `firefox`
- [`rcarriga/nvim-dap-ui`](https://github.com/rcarriga/nvim-dap-ui)
- [`jay-babu/mason-nvim-dap.nvim`](https://github.com/jay-babu/mason-nvim-dap.nvim)
- [`theHamsta/nvim-dap-virtual-text`](https://github.com/theHamsta/nvim-dap-virtual-text)
- [`LiadOz/nvim-dap-repl-highlights`](https://github.com/LiadOz/nvim-dap-repl-highlights)

### Git

- [`lewis6991/gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim)
- [`akinsho/git-conflict.nvim`](https://github.com/akinsho/git-conflict.nvim)

### Testing

- [`nvim-neotest/neotest`](https://github.com/nvim-neotest/neotest)
- [`nvim-neotest/nvim-nio`](https://github.com/nvim-neotest/nvim-nio)
- [`nvim-lua/plenary.nvim`](https://github.com/nvim-lua/plenary.nvim)
- [`V13Axel/neotest-pest`](https://github.com/V13Axel/neotest-pest)
- [`olimorris/neotest-phpunit`](https://github.com/olimorris/neotest-phpunit)
- [`marilari88/neotest-vitest`](https://github.com/marilari88/neotest-vitest)

## Keymaps

- Diagnostics
  - `[d` and `]d` : Jump to previous and next diagnostics
  - `[e` and `]e` : Jump to previous and next error diagnostics
  - `[w` and `]w` : Jump to previous and next warning diagnostics
  - `<leader>`+`e` : Open floating diagnostic message
  - `<leader>`+`ea` : Open workspace diagnostics
  - `<leader>`+`ee` : Open buffer diagnostic
- Buffer
  - `<` and `>` : Dedent and Indent line(s) on `visual` mode
  - `ALT`+`j`/`k` : Move line(s) down or up
  - `<leader>`+`fo` : Format current buffer
- Panes / Splits
  - `ALT`+`Up`/`Down` arrow : Increase or decrease window height
  - `ALT`+`Left`/`Right` arrow : Decrease or increase window width
  - `CTRL`+`h`/`j`/`k`/`l` : Jump to `left`, `below`, `above` or `right` window
  - `CTRL`+<code>`</code> : Toggle integrated terminal
- Language Services
  - `K` : Show signature help
  - `gd` : Goto Definition
  - `gD` : Goto Declaration
  - `gr` : Goto References
  - `gi` : Goto Implementation
  - `gy` : Goto Type Definition
  - `<leader>`+`s` : Workspace Symbols
  - `<leader>`+`ss` : Document Symbols
  - `<leader>`+`rn` : Rename Symbol
  - `<C-.>` : Code Action
- Git
  - `<leader>`+`gg` : Open lazygit
  - `<leader>`+`gl` : Toggle Git Logs Picker
  - Hunks
    - `[h` and `]h` : Jump to previous and next hunk
    - `[H` and `]H` : Jump to first and last hunk
    - `<leader>`+`hs` : Toggle Stage Hunk
    - `<leader>`+`hS` : Toggle Stage Buffer
    - `<leader>`+`hr` : Reset Hunk
    - `<leader>`+`hR` : Reset Buffer
    - `<leader>`+`h?` : Toggle Preview Hunk
  - Conflicts
    - `<leader>`+`co` : Choose ours
    - `<leader>`+`ct` : Choose theirs
    - `<leader>`+`c0` : Choose none
    - `<leader>`+`cb` : Choose both
- File Navigations
  - `TAB` or `SHIFT`+`TAB` : Navigate to next or previous buffers (normal mode)
  - `n` and `N` : Jump to previous and next search results and keep the cursor in the center
  - `<leader>`+`f` : File explorer
  - `<leader>`+`ff` : Find Buffers
  - `<leader>`+`fg` : Find File in current git repo
  - `<leader>`+`r` : Rename File
  - `<leader>`+`<space>` : File Picker
  - `<C-f>` : Find files
  - `<C-p>` : Projects Picker
- Testing
  - `<leader>`+`t` : Toggle Test Summary
  - `<leader>`+`tr` : Test Run
  - `<leader>`+`tx` : Test stop
  - `<leader>`+`td` : Test run with DAP
  - `<leader>`+`tf` : Test File
  - `<leader>`+`ts` : Test Suite
  - `<leader>`+`to` : Test Output
  - `<leader>`+`tp` : Test Output Panel
- Debugging
  - `F1` : Debug: Step into
  - `F2` : Debug: Step over
  - `F3` : Debug: Step out
  - `F4` : Debug: Step back
  - `F5` : Start debugger
  - `F7` : Toggle DAP UI
  - `<leader>`+`db` : Toggle breakpoint
  - `<leader>`+`dc` : Clear all breakpoints
  - `<leader>`+`dd` : Evaluate value under the cursor

## License

This repo is licensed under [WTFPL](LICENSE)
