![normal](https://user-images.githubusercontent.com/729055/174136946-1f0cc857-a4cf-46b8-9781-8b8d336b776c.jpg)

# hackline.vim

A lightweight Neovim/Vim statusline plugin. No setup or prerequisites required. Enjoy the minimalism! Yet it's quite fully featured, with some features through optional plugins.

- **No prerequisites** like icons or patched font, but there are variables to use some for something like this. ![some-power](https://user-images.githubusercontent.com/729055/176041696-46676bbe-2a18-4f7a-aad0-75cbdb56b1ac.jpg)
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

By default colors depends on your colorscheme. Here with [Iceberg](https://cocopon.github.io/iceberg.vim/) (don't mind the bottom line of the terminal, which is tmux):

![insert](https://user-images.githubusercontent.com/729055/174136970-bca8a857-9bc8-4a38-bf51-1484b626263b.jpg)
![visual](https://user-images.githubusercontent.com/729055/174136979-7599b2ca-67a8-462f-9436-2100ff27087a.jpg)
![narrow](https://user-images.githubusercontent.com/729055/174137072-07b9f0bd-6b95-41ca-b536-5dc6a8ade4a1.jpg)
![split](https://user-images.githubusercontent.com/729055/174137089-ed5f0fde-b41e-49ef-bd98-dd16f9ade287.jpg)

## Options

Global variables for simple customization.

Default values:

```vim
" Active status:
let g:hackline_laststatus = 2
let g:hackline_mode = 1
let g:hackline_bufnum = 1
let g:hackline_filetype = 1
let g:hackline_ale = 0 " ALE errors and warnings if available
let g:hackline_nvim_lsp = 1 " Native nvim LSP info if available
let g:hackline_vim_lsp = 1 " Vim LSP info if available
let g:hackline_git = 1 " Current branch if available from plugins
let g:hackline_encoding = 1
let g:hackline_fileformat = 1
let g:hackline_tab_info = 1

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

" Mode highlight groups:
let g:hackline_highlight_normal = 'StatusLine'
let g:hackline_highlight_insert = 'Todo'
let g:hackline_highlight_visual = 'PmenuSel'
let g:hackline_highlight_replace = 'IncSearch'
let g:hackline_highlight_select = 'IncSearch'
let g:hackline_highlight_command = 'DiffAdd'
let g:hackline_highlight_terminal = 'DiffAdd'
" Highlight groups for more content with background by default:
let g:hackline_highlight_end = 'StatusLine'
let g:hackline_highlight_inactive = 'StatusLineNC'
```

In Neovim, you can configure with Lua like so:

```lua
vim.g.hackline_laststatus = 3
-- ...etc.
```

---

Some examples

```vim
" Add your own three letter signature:
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

![some-power](https://user-images.githubusercontent.com/729055/176041696-46676bbe-2a18-4f7a-aad0-75cbdb56b1ac.jpg)

```vim
" Custom end is avaluated as statusline content:
let g:hackline_custom_end = '
			\%( words %{wordcount().words} %)
			\%( %{hackline#base#filesize()} %)
			\ %P/%L 
			\'
```

### Extra functions

- **File size** function (originally from skyline.vim): `hackline#base#filesize()`
- **Tabs or spaces**, and their size, function (active by default from `g:hackline_tab_info`): `hackline#base#tab_info()`
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

This is approx. version 0.9.3---it will probably not have breaking changes or break in general. Check tags and branches for older/newer versions.

Originally a fork of the lightweight [skyline.vim](https://github.com/ourigen/skyline.vim) which has a different look.

### *Future*

- Versioning: A v1 branch/tag will be created once it hits v1. Main branch wil be kept as stable as possible with new updates.
- Add Vim help documentation.
- Nvim LSP number of buffer warning/errors?
- Update/add dirty Git branch (through plugin support---vgit?).
- Support hi `StatusLineTerm` and `StatusLineTermNC`?
