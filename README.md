# hackline.vim

A minimalistic, light statusline package (plugin) for newer Vims/Neovims, embracing newer vanilla capabilities of the editor. *No, this is not Lua (with exceptions), only easy to hack Vimscript. Originally a fork of [skyline.vim](https://github.com/ourigen/skyline.vim). This is approx. version 0.9---things change and break.*

Plug-and-play with any simple way to install, e.g., with packer.nvim: `use{'jssteinberg/hackline.vim'}`.

![Skjermbilde 2021-12-12 kl  19 37 28](https://user-images.githubusercontent.com/729055/145725137-e9244f03-a1ad-49b9-8f91-42ff6d7f8a42.jpg)
![Skjermbilde 2021-12-12 kl  19 36 13](https://user-images.githubusercontent.com/729055/145725141-0f2b8ed2-72c0-4e3f-8b91-57c15cecfca0.jpg)
![Skjermbilde 2021-12-12 kl  19 36 55](https://user-images.githubusercontent.com/729055/145725144-76eedabc-5f63-4397-8aa0-c458fb56add4.jpg)

## Features

- **No icons** or need for patched font.
- **No themes**---uses normal color highlight groups. Looks good with any newer colorscheme.
- **Good contrast** for horizontal splits.
- **Minimal mode flag** for Vim professionals! (Sets `noshowmode` if on).
- **Responsive**---adjusts statusline for smaller widths.
- **All buffer types** uses same settings---no specific buffer targeting. hackline.vim is just setup as dynamically as possible in how items are sorted and truncated, but still keeping them nice and logical for main buffers. *Helps to keep a light weight.*

### Integrations

- **Git** info by using the one of the following packages/plugins. hackline.vim connects in order: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [vim-gitbranch](https://github.com/itchyny/vim-gitbranch), [vim-fugitive](https://github.com/tpope/vim-fugitive).
- **LSP** currently connected with Neovim buffer.
- **ALE** if active for buffer and the number of errors and warnings.

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

Requires a newer version of Vim > 8.2.1[something] or Neovim. Basically a newer version that supports re-evaluating expression results as a statusline format string. Not tested on Vim without lua---for Mac, Homebrew Vim works.

Install examples:

```lua
-- packer.nvim
use{'jssteinberg/hackline.vim'}
```

```lua
-- packer.nvim with git info (without gitsigns or fugitive)
use{'jssteinberg/hackline.vim', requires = {'itchyny/vim-gitbranch'}}
```

```vim
" Vim packager
call packager#add('jssteinberg/hackline.vim')
```

(And it should be equally simple with vim-plug).

## Options

Global variables for simple customization.

Default values:

```vim
let g:hackline_mode = 1
let g:hackline_bufnum = 1
let g:hackline_filetype = 1
let g:hackline_ale = 1 " ALE info if available
let g:hackline_nvim_lsp = 1 " Native nvim LSP info if available
let g:hackline_git = 1 " Current branch if available from plugins
let g:hackline_encoding = 1
let g:hackline_fileformat = 1
let g:hackline_tab_info = 1
" Any valid statusline value
let g:hackline_custom_end = '
			\ %P/%L 
			\'
```
