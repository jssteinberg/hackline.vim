# hackline.vim

*hackline.vim 'hacks' your statusline so you don't have to.*

The minimalist's statusline plugin for Neovim/Vim. It's lightweight, loads in no-time, but quite fully featured, with some features through optional plugins.

- **No prerequisites** like icons or patched font, but there are simple variables for adding it.
- **Uses your colorscheme.** Uses already exisiting highlight groups, but can be customized if needed.
- **Mode flag** (minimal by default) when not normal mode.
- **Responsive**---adjusts statusline for smaller widths.
- **All buffer types** uses same settings---no specific buffer targeting. hackline.vim is just setup as dynamically as possible in how items are sorted and truncated, but still keeping them nice and logical for main buffers.

Integrations:

- **LSP** flag if connected to buffer. Supports [Neovim's LSP](https://github.com/neovim/nvim-lspconfig). And [vim-lsp](https://github.com/prabirshrestha/vim-lsp) (only simple flag if active LSP in buffer).
- **Git** info is bring-your-own function (from a plugin usually), or by opting-in to the built-in support for one of the following plugins (though maintenance of plugin support can not be ensured) connected to in order: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [vim-fugitive](https://github.com/tpope/vim-fugitive), [vim-gitbranch](https://github.com/itchyny/vim-gitbranch). [VGit](https://github.com/tanvirtin/vgit.nvim) can supplement the two latter with Git status.

*Why another statusline plugin?* hackline.vim is hacked to be the lightest statusline plugin for experienced Vim users, with no config needed for all features.
There's no patched font or icons dependency.

## Installation

Neovim example with packer.nvim:

```lua
use {
	"jssteinberg/hackline.vim",
	requires = { "itchyny/vim-gitbranch" },
	config = function()
		-- disable command line mode flag
		vim.opt.showmode = false
		-- built-in git plugin support (maintenance can not be ensured---you can bring-you-own Git function for safety)
		vim.g.hackline_git_info = true
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

" Vim packager
call packager#add('jssteinberg/hackline.vim')

" vim-jetpack
call jetpack#add('jssteinberg/hackline.vim')
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
let g:hackline_git_info = "" " Set to a function or use `1`/`v:true` for built-in
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

- mv separators to level based separators, e.g., "sep_inner" something.
- Add Vim help documentation.
- mode contextual information such as number of characters, words in visual selection.
- Nvim LSP number of buffer warning/errors?
- Support hi `StatusLineTerm` and `StatusLineTermNC`?
