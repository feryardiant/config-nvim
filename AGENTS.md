# AGENTS.md

Personal Neovim config (LazyVim-style, hand-rolled). Cloned to `~/.config/nvim`.

## Commands

- Fresh install / after changing plugin specs:
  `nvim --headless '+Lazy! sync' +qa`, then open a file once (tree-sitter + Mason), then `:MasonToolsInstallSync`.
- Editing `lua/**` only needs an nvim restart to take effect. No build step.
- `lazy-lock.json` is **gitignored**: plugin versions are never pinned in git. Expect upstream drift.
- Requires Neovim ≥ 0.11 (uses `vim.lsp.config`/`vim.lsp.enable` and the nvim-treesitter rewrite API).

## Layout

- `lua/plugins/*.lua` — lazy.nvim specs, auto-imported via `{ import = 'plugins' }` in `init.lua`. One file per concern. No registration needed for a new file. A spec file may also register top-level autocmds at load time (see `plugins/lsp.lua`), so it is not necessarily a pure `return {...}`.
- `lua/bootstrap.lua` — sets leaders, then loads `lua/custom/{autocmds,options,keymaps}.lua` at startup.
- `lua/custom/lsp-servers/*.lua` — per-server `vim.lsp.Config` overrides; index file (`lua/custom/lsp-servers.lua`) metatable auto-merges default `filetypes` from `lspconfig.configs.<name>` and sorts them.
- `lua/utils/*` — shared helpers: `keymap.create`/`delete` registry, `php` (installed extensions, composer home), `fs`, `workspace`. `utils` is lazy-loaded; require it inside functions, never at module top level of plugins.
- `queries/<parser>/<querytype>.scm` — custom tree-sitter queries; the config dir is on the runtimepath. `queries/dotenv/` backs a custom `dotenv` parser registered in `plugins/treesitter.lua`.

## LSP conventions (important)

- Modern flow only: servers auto-enable from the `ensure_installed` list in `plugins/lsp.lua` via `vim.lsp.enable`. **Do not** reintroduce legacy `opts.handlers` from mason-lspconfig.
- To add/configure a server: add its mason name to `ensure_installed` in `plugins/lsp.lua`, then create `lua/custom/lsp-servers/<name>.lua` returning a `vim.lsp.Config` (annotate `---@type vim.lsp.Config`).
- Shared capabilities for blink.cmp are set via `vim.lsp.config('*', ...)`.
- TS/JS uses `vtsls` (replaced `ts_ls`), Vue uses `vue_ls` (not volar). `intelephense` is commented out in favor of `phpantom_lsp`. Blade highlighting comes built-in from `treesitter-blade` — no custom blade query/filetype override.

## Code style

- Lua: stylua via conform on save (`<leader>fo` formats). `.stylua.toml`: 2-space indent, single quotes; `-- stylua: ignore` is used deliberately around hand-kept blocks.
- LuaLS annotations (`---@type`, `---@module`, `---@param`) on opts/configs throughout — keep them accurate; `nvim.log` catches type diagnostics on save (see `.luarc.json`).
- `.tool-versions` pins `lua 5.5.1` (asdf). PHP tooling prefers `pint` (mason or `vendor/bin/pint`).
- Git: conventional commits scoped by area, e.g. `fix(lsp):`, `chore(debugging):`.

## Gotchas

- Neovim buffer option indentation is 4 (`custom/options.lua`); stylua still formats Lua at 2. Don't "fix" the mismatch.
- nvim-treesitter rewrite: install parsers with `nvim_treesitter.install { 'name', ... }`, not `ensure_installed`.
- `.env.*` maps to the `dotenv` filetype and is value-cloaked by `cloak.nvim` (`plugins/editor.lua`) — edits to those patterns are intentional.
