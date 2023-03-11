# hackline.vim

*hackline.vim 'hacks' your statusline so you don't have to.*

The minimalist's statusline package/plugin for Vim and Neovim. It's lightweight, loads in no-time, still quite fully featured, with some features through optional plugins.

- **No prerequisites** like patched icon fonts. It has simple options for changing separators.
- **Supports any colorscheme** by being a normal Vim statusline. Highlight groups can be changed per mode, but changes the entire statusline for its context.
- **Mode flag** when not normal mode. Minimal by default.
- **Responsive design** adjusts and truncates on priority for smaller widths.
- **All buffers** uses same settings. No bloat with specific buffer/file type targeting. hackline.vim is just setup as dynamically as possible in how items are sorted and truncated, but still keeping them nice and logical for main buffers.

Integrations:

- **LSP** flag if connected to buffer. Supports [Neovim's LSP](https://github.com/neovim/nvim-lspconfig). And [vim-lsp](https://github.com/prabirshrestha/vim-lsp) (only simple flag if active LSP in buffer).
- **Git** info is bring-your-own function (from a plugin usually), or falls back to the built-in support for one of the following plugins (though maintenance of plugin support can not be ensured) connected to in order: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [vim-fugitive](https://github.com/tpope/vim-fugitive), [vim-gitbranch](https://github.com/itchyny/vim-gitbranch). [VGit](https://github.com/tanvirtin/vgit.nvim) can supplement the two latter with Git status.

*Why another statusline plugin?*
Hackline.vim needs no customizing or no patched icon font. It’s not for the shallow, but hacked to be the lightest statusline plugin for pragmatic speed freak vimmers. In all honesty, the barebones Vim features hackline.vim uses has drawbacks, but that’s worked around by hackline‘s design choices and not noticeable. The advantage is load time. Also, it’s fast.

## Installation

Neovim example with packer.nvim:

```lua
use {
	"jssteinberg/hackline.vim",
	requires = { "itchyny/vim-gitbranch" },
	config = function()
		-- disable command line mode flag
		vim.opt.showmode = false
		-- show CWD folder
		vim.g.hackline_cwd = true
		-- no inline padding (padding x-axis)
		vim.g.hackline_normal_px = 0
	end
}
```

<details>
<summary>For Vim</summary>

```vim
" minpac
call minpac#add('jssteinberg/hackline.vim')
```

(And it should be equally simple with vim-plug).

</details>

hackline.vim requires Neovim or Vim version > 8.2.1[something]---basically a newer version that supports re-evaluating expression results as a statusline format string.
For Mac, you can use Vim from Homebrew.

hackline.vim is tested on Neovim and Vim compiled with lua (but should work without Lua).

## Options

Global variables for simple customization. Default values:

```vim
" Set option:
let g:hackline_laststatus = 2 " same as `laststatus`
let g:hackline_normal_px = 0 " inline padding (padding x-axis) for normal mode

" Toggle statusline info:
let g:hackline_mode = 1 " To activate mode flags and not deactivating `showmode`
let g:hackline_cwd = 0 " Show current Vim working folder
let g:hackline_git_info = 1 " Set to a function for bring-your-own Git info
let g:hackline_nvim_lsp = 1 " Native nvim LSP info if available
let g:hackline_vim_lsp = 1 " Vim LSP info if available

" Separators and signs:
let g:hackline_separators = #{ l: '/', r: '/' }
let g:hackline_branch_sign = "*"
" for vgit
let g:hackline_git_signs = #{
			\added: "+",
			\removed: "-",
			\changed: "~",
			\}

" Mode labels:
let g:hackline_label_command  = "—C—"
let g:hackline_label_insert   = "–I–"
let g:hackline_label_terminal = "–T–"
let g:hackline_label_visual   = "–V–"
let g:hackline_label_select   = "–S–"
let g:hackline_label_replace  = "–R–"

" Set statusline items for the far right of the statusline:
let g:hackline_statusline_items_end = "Ln %l/%L Col %c"

" Set highlight groups:
let g:hackline_highlight_inactive = 'StatusLineNC'
let g:hackline_highlight_normal = 'StatusLine'
let g:hackline_highlight_insert = 'Todo'
let g:hackline_highlight_visual = 'PmenuSel'
let g:hackline_highlight_replace = 'IncSearch'
let g:hackline_highlight_select = 'IncSearch'
let g:hackline_highlight_command = 'DiffAdd'
let g:hackline_highlight_terminal = 'DiffAdd'
```

### Some examples

```vim
" You can define your own highlight groups:
let g:hackline_highlight_normal = 'HacklineNormal'
" ...and something:
hi! link HacklineNormal Search
" ...or something else:
hi HacklineNormal guibg=... guifg=...
```

```vim
" If you have a patched font, you can get a minor powerline feel:
let g:hackline_separators = #{ l: "", r: "" }
let g:hackline_branch_sign = " "
```

In Neovim, you can configure with Lua like so:

```lua
vim.g.hackline_laststatus  = 3
vim.g.hackline_branch_sign = " "
vim.g.hackline_separators  = { l = "", r = "" }
-- ...etc.
```

### Extra functions

- **File size** function (originally from skyline.vim): `hackline#base#filesize()`
- **Tabs or spaces**, and their size, function: `hackline#tab#info()` (pass parameter `1` to truncate info).
- Also see `:help statusline`


## About development

This is v3.0.0-0.

Originally a fork of the lightweight [skyline.vim](https://github.com/ourigen/skyline.vim) which has a different look.

### *Future*

- Highlight group for unsaved
- Add Vim help documentation.
- mode contextual information such as number of characters, words in visual selection.
- Nvim LSP number of buffer warning/errors?
- Support hi `StatusLineTerm` and `StatusLineTermNC`?
