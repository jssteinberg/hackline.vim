# hackline.vim

A light Neovim/Vim statusline. Light and simple code, though with important batteries included (some through optional plugin dependencies). *Originally a fork of [skyline.vim](https://github.com/ourigen/skyline.vim). This is approx. version 0.9.2---it will probably not have breaking changes or break in general.*

Plug-and-play with any simple way to install, e.g., using packer.nvim: `use{'jssteinberg/hackline.vim'}`.

*hackline.vim colors depends on colorscheme. Here with [Iceberg](https://cocopon.github.io/iceberg.vim/) (don't mind the bottom line of the terminal, which is tmux):*

![normal](https://user-images.githubusercontent.com/729055/174136946-1f0cc857-a4cf-46b8-9781-8b8d336b776c.jpg)
![insert](https://user-images.githubusercontent.com/729055/174136970-bca8a857-9bc8-4a38-bf51-1484b626263b.jpg)
![visual](https://user-images.githubusercontent.com/729055/174136979-7599b2ca-67a8-462f-9436-2100ff27087a.jpg)
![narrow](https://user-images.githubusercontent.com/729055/174137072-07b9f0bd-6b95-41ca-b536-5dc6a8ade4a1.jpg)
![split](https://user-images.githubusercontent.com/729055/174137089-ed5f0fde-b41e-49ef-bd98-dd16f9ade287.jpg)

## Features

- **No icons** or need for patched font.
- **No new color highlight groups**---uses already exisiting color highlight groups to avoid colorschemes having to support the plugin specifically.
- **Minimal mode flag** for Vim professionals! (Sets `noshowmode` if on).
- **Responsive**---adjusts statusline for smaller widths.
- **All buffer types** uses same settings---no specific buffer targeting. hackline.vim is just setup as dynamically as possible in how items are sorted and truncated, but still keeping them nice and logical for main buffers. *Helps to keep a light weight.*

*Someone should confirm loading time. Low right?*

### Integrations

- **Git** info by using the one of the following packages/plugins. hackline.vim connects in order: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [vim-gitbranch](https://github.com/itchyny/vim-gitbranch), [vim-fugitive](https://github.com/tpope/vim-fugitive).
- **LSP** flag if connected to buffer. Supports [Neovim's LSP](https://github.com/neovim/nvim-lspconfig).
And [vim-lsp](https://github.com/prabirshrestha/vim-lsp) (only simple flag if active LSP in buffer).
<!--
- **ALE** if active for buffer and the number of errors and warnings.
-->

### Options

Global variables for simple customization.

Default values:

```vim
" Statusline content
let g:hackline_laststatus = 2
let g:hackline_mode = 1
let g:hackline_bufnum = 1
let g:hackline_filetype = 1
let g:hackline_ale = 0 " ALE info if available (not tested much)
let g:hackline_nvim_lsp = 1 " Native nvim LSP info if available
let g:hackline_vim_lsp = 1 " Vim LSP info if available
let g:hackline_git = 1 " Current branch if available from plugins
let g:hackline_encoding = 1
let g:hackline_fileformat = 1
let g:hackline_tab_info = 1
" any valid statusline value that will be added to end of statusline
let g:hackline_custom_end = '
			\ %P/%L 
			\'

" Mode highlight groups
let g:hackline_normal = 'StatusLine'
let g:hackline_command = 'Todo'
let g:hackline_insert = 'DiffAdd'
let g:hackline_terminal = 'Todo'
let g:hackline_visual = 'PmenuSel'
let g:hackline_replace = 'IncSearch'
let g:hackline_select = 'IncSearch'
```

Or, in Neovim, redefine with Lua:

```lua
vim.g.hackline_laststatus = 3
-- ...etc.
```

### Extra functions

- **Tabs or spaces**, and size, function `hackline#base#tab_info()`.
- **Word count** function (from skyline.vim): `hackline#base#wordcount()`.
- **File size** function (from skyline.vim): `hackline#base#filesize()`.

Example use:

```vim
let g:hackline_custom_end = '
			\%( words %{hackline#base#wordcount()} %)
			\%( %{hackline#base#filesize()} %)
			\ %P/%L 
			\'
```

## Installation

Requires a newer version of Vim > 8.2.1[something] or Neovim. Basically a newer version that supports re-evaluating expression results as a statusline format string. Not tested on Vim without lua. For Mac, Vim from Homebrew works.

Install in Neovim:

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

Install in Vim:

```vim
" Vim packager
call packager#add('jssteinberg/hackline.vim')

" vim-jetpack
call jetpack#add('jssteinberg/hackline.vim') " Light statusline
```

(And it should be equally simple with vim-plug).

## *Plans*

- Versions: Create a v1 branch once it hits v1, and keep main branch as stable as possible with new updates.
- Add Vim help documentation.
- Nvim LSP number of buffer warning/errors?
- Update/add dirty Git branch (through plugin support---vgit?).
