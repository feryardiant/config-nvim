# My personal NeoVim config

## Keymaps

- Diagnostics
  - `[d` and `]d` : Jump to previous and next diagnostics
  - `[e` and `]e` : Jump to previous and next error diagnostics
  - `[w` and `]w` : Jump to previous and next warning diagnostics
  - `<leader>`+`e` : Open floating diagnostic message
  - `<leader>`+`q` : Open diagnostic list
  - `<leader>`+`xx` : [Trouble] Toggle diagnostics
  - `<leader>`+`xX` : [Trouble] Buffer diagnostics
  - `<leader>`+`xs` : [Trouble] Symbols
  - `<leader>`+`xl` : [Trouble] LSP Definitions
  - `<leader>`+`xL` : [Trouble] Location list
  - `<leader>`+`xq` : [Trouble] Quickfix list
- Buffer
  - `<` and `>` : Dedent and Indent line(s) on `visual` mode
  - `ALT`+`j`/`k` : Move line(s) down or up
  - `CTRL`+`j`/`k` : Scroll 4 lines down or up
  - `TAB` or `SHIFT`+`TAB` : Navigate to next or previous completion item
  - `<leader>`+`fb` : Format current buffer
  - `<leader>`+`fl` : Lint current buffer
- Panes / Splits
  - `ALT`+`Up`/`Down` arrow : Increase or decrease window height
  - `ALT`+`Left`/`Right` arrow : Decrease or increase window width
  - `CTRL`+`h`/`j`/`k`/`l` : Jump to `left`, `below`, `above` or `right` window
  - `CTRL`+<code>`</code> : Toggle integrated terminal
- File Navigations
  - `[b` and `]b` : Jump to previous and next buffer windows
  - `n` and `N` : Jump to previous and next search results and keep the cursor in the center
  - `gd` : [G]oto [D]efinition
  - `gD` : [G]oto [D]eclaration
  - `gr` : [G]oto [R]eferences
  - `gI` : [G]oto [I]mplementation
  - `K` : Show signature help
  - `<leader>`+`D` : Type [D]efinition
  - `<leader>`+`ds` : [D]ocument [S]ymbols
  - `<leader>`+`ws` : [W]orkspace [S]ymbols
  - `<leader>`+`rn` : [R]e[n]ame
  - `<leader>`+`ca` : [C]ode [A]ction
  - `<leader>`+`th` : [T]oggle Signature [H]elp (if any)
  - `<leader>`+`ge` : Git explorer
  - `<leader>`+`be` : Buffers explorer
  - `<leader>`+`fe` : File explorer
  - `<leader>`+`<space>` : Find files from existing buffer
  - `<leader>`+`ff` : Find files
  - `<leader>`+`fw` : Find current word
  - `<C-p>` : Find files inside git repository
  - `<leader>`+`ds` : Find document symbols
- Testing
  - `<leader>`+`tr` : [T]est [R]un
  - `<leader>`+`tx` : [T]est stop
  - `<leader>`+`td` : [T]est run with [D]AP
  - `<leader>`+`tf` : [T]est [F]ile
  - `<leader>`+`ts` : [T]est [S]uite
  - `<leader>`+`to` : [T]est [O]utput
  - `<leader>`+`top` : [T]est [O]utput [P]anel
  - `<leader>`+`tS` : Toggle [T]est [S]ummary
- Debugging
  - `F1` : Debug: Step into
  - `F2` : Debug: Step over
  - `F3` : Debug: Step out
  - `F4` : Debug: Step back
  - `F5` : Start debugger
  - `F7` : Toggle DAP UI
  - `<leader>`+`b` : Toggle breakpoint
  - `<leader>`+`?` : Debug: Evaluate value under the cursor

## License

This repo is licensed under [WTFPL](LICENSE)
