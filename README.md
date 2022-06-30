![normal](https://user-images.githubusercontent.com/729055/176217352-d0942b97-e04d-4de4-b9e1-dd2f75cda5cc.png)

# hackline.vim

A lightweight Neovim/Vim statusline plugin. No setup or prerequisites required. Enjoy the minimalism! Yet it's quite fully featured, with some features through optional plugins.

- **No prerequisites** like icons or patched font, but there are simple variables for adding it.
- **Uses your colorscheme.** Uses already exisiting highlight groups, but can be customized if needed.
- **Minimal mode flag** for Vim professionals! Sets `noshowmode` if on---on by default.
- **Responsive**---adjusts statusline for smaller widths.
- **All buffer types** uses same settings---no specific buffer targeting. hackline.vim is just setup as dynamically as possible in how items are sorted and truncated, but still keeping them nice and logical for main buffers.

Integrations:

- **Git** info by using the one of the following packages/plugins. hackline.vim connects in order: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [vim-fugitive](https://github.com/tpope/vim-fugitive), [vim-gitbranch](https://github.com/itchyny/vim-gitbranch).
- **LSP** flag if connected to buffer. Supports [Neovim's LSP](https://github.com/neovim/nvim-lspconfig).
And [vim-lsp](https://github.com/prabirshrestha/vim-lsp) (only simple flag if active LSP in buffer).
- **ALE** errors and warnings if active for buffer.

*Someone should confirm loading time. Low right?*

Default colors depends on your colorscheme. Here with [Iceberg](https://cocopon.github.io/iceberg.vim/):

![insert](https://user-images.githubusercontent.com/729055/176217647-9c464f60-91d3-405f-8fc0-c66feaca1541.png)
![visual](https://user-images.githubusercontent.com/729055/176217668-2f5a1ccd-4f0a-469f-8912-fad630dd0e03.png)
![replace](https://user-images.githubusercontent.com/729055/176217697-f548262d-d277-4752-8419-b064d6e0df67.png)

## Options

Global variables for simple customization.

Default values:

```vim
" Active status:
let g:hackline_laststatus = 2
let g:hackline_mode = 1
let g:hackline_bufnum = 0
let g:hackline_filetype = 1
let g:hackline_ale = 0 " ALE errors and warnings if available
let g:hackline_nvim_lsp = 1 " Native nvim LSP info if available
let g:hackline_vim_lsp = 1 " Vim LSP info if available
let g:hackline_git = 1 " Current branch if available from plugins
let g:hackline_encoding = 1
let g:hackline_fileformat = 1

" Separators and signs:
let g:hackline_separators = #{ l: '›', r: '‹' }
let g:hackline_branch_sign = "* "

" Mode labels:
let g:hackline_sign = has("nvim") ? "Neo" : "Vim"
let g:hackline_label_command  = "«C»"
let g:hackline_label_insert   = "«I»"
let g:hackline_label_terminal = "«T»"
let g:hackline_label_visual   = "«V»"
let g:hackline_label_select   = "«S»"
let g:hackline_label_replace  = "«R»"

" A valid statusline value that will be added to end of statusline:
let g:hackline_custom_end = '
			\ %P/%L 
			\'

" Highlight groups:
let g:hackline_highlight_inactive = 'StatusLineNC'
let g:hackline_highlight_normal = 'StatusLine'
let g:hackline_highlight_insert = 'Todo'
let g:hackline_highlight_visual = 'PmenuSel'
let g:hackline_highlight_replace = 'IncSearch'
let g:hackline_highlight_select = 'IncSearch'
let g:hackline_highlight_command = 'DiffAdd'
let g:hackline_highlight_terminal = 'DiffAdd'
let g:hackline_highlight_secondary = 'Comment'
let g:hackline_highlight_items = 'Normal'
let g:hackline_hightlight_branch = 'String'
let g:hackline_highlight_end = 'StatusLine'
```

---

Some examples

```vim
" Add your own signature (three letters ot avoid 'layout' shifts):
let g:hackline_sign = "Hck"
" ..or signal 'normal mode':
let g:hackline_sign = "«N»"
```

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

![power](https://user-images.githubusercontent.com/729055/176217828-f5642220-9b6f-4306-a5f3-ec166eee31a9.png)

```vim
" Custom end is avaluated as statusline content:
let g:hackline_custom_end = '
			\%( %{hackline#base#filesize()} %)
			\ %P/%L 
			\'
```

---

In Neovim, you can configure with Lua like so:

```lua
vim.g.hackline_laststatus = 3
vim.g.hackline_custom_end =
	"%( %{hackline#tab#info(1)} %)"
	.. " %P/%L "
vim.g.hackline_branch_sign = " "
vim.g.hackline_separators = { l = "", r = "" }
-- ...etc.
```

### Extra functions

- **File size** function (originally from skyline.vim): `hackline#base#filesize()`
- **Tabs or spaces**, and their size, function: `hackline#tab#info()` (pass parameter `1` to truncate info).
- Also see `:help statusline`

## Installation

Requires a newer version of Vim > 8.2.1[something] or Neovim. Basically a newer version that supports re-evaluating expression results as a statusline format string. Not tested on Vim without lua. For Mac, Vim from Homebrew works.

Neovim install:

```lua
-- packer.nvim
use{'jssteinberg/hackline.vim'}
```

```lua
-- packer.nvim with git info (without gitsigns or fugitive)
use{'jssteinberg/hackline.vim', requires = {'itchyny/vim-gitbranch'}}

-- Even lazyload it (does that makes sense?):
use { 'jssteinberg/hackline.vim', event = 'CursorHold' }
use { 'itchyny/vim-gitbranch', event = 'CursorHold' }
```

Vim install:

```vim
" minpac
call minpac#add('jssteinberg/hackline.vim')

" Vim packager
call packager#add('jssteinberg/hackline.vim')

" vim-jetpack
call jetpack#add('jssteinberg/hackline.vim')
```

(And it should be equally simple with vim-plug).

## About development

This is v2.0.0-1.

Version 1: See branch v1.

Originally a fork of the lightweight [skyline.vim](https://github.com/ourigen/skyline.vim) which has a different look.

### *Future*

- Add Vim help documentation.
- Nvim LSP number of buffer warning/errors?
- Update/add dirty Git branch (through plugin support---vgit?).
- Support hi `StatusLineTerm` and `StatusLineTermNC`?
