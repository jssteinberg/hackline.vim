# hackline.vim

<img width="951" alt="Skjermbilde 2021-12-05 kl  22 03 09" src="https://user-images.githubusercontent.com/729055/144764748-1cb3d1a6-9ade-4915-a973-cc9d0338b4fb.png">
<img width="1416" alt="Skjermbilde 2021-12-05 kl  22 31 42" src="https://user-images.githubusercontent.com/729055/144764795-bf2a5252-7079-4f68-85e4-453de959e4e9.png">

*Version 0.2---things may break.*

A light weight statusline package embracing vanilla capabilities. Easy to copy and hack! Originally a fork of [skyline.vim](https://github.com/ourigen/skyline.vim).

* Minimal mode flag for Vim professionals! (Sets `noshowmode` if on).
* No themes available or needed---uses usual Vim highlight groups. Has good contrast for horizontal splits.
* Adjusts statusline for smaller widths. Sort statusline items logically for many buffer types, including netrw.
* No icons or need for patched font.
* Word count modules (from skyline.vim).
* File size modules (from skyline.vim).

Plugins integrations:

* Shows current git branch if one of either plugin [vim-gitbranch](https://github.com/itchyny/vim-gitbranch) or [vim-fugitive](https://github.com/tpope/vim-fugitive) is loaded.
* Shows connected Neovim LSP.
* Shows if ALE is active and number of error/warnings.

## Installation

Requires a newer version of Vim > 8.2.1[something] or Neovim. Basically a newer version that supports re-evaluating expression results as a statusline format string. Not tested on Vim without lua---for Mac, Homebrew Vim works.

Pick your poison:

```
use{'jssteinberg/hackline.vim'} -- packer.nvim, or with additional requirements:
use{'jssteinberg/hackline.vim', requires = {'itchyny/vim-gitbranch'}} -- For Git branch without fugitive.vim

Plug 'jssteinberg/hackline.vim' " vim-plug

call packager#add('jssteinberg/hackline.vim') " Vim packager
```

## Options

Global variables for simple customization.

Default values:

```vim
let g:hackline_bufnum = 1
let g:hackline_mode = 1
let g:hackline_git = 1 " Current branch if available from vim-gitbranch or fugitive.vim
let g:hackline_ale = 1 " ALE info if available
let g:hackline_nvim_lsp = 1 " Native nvim LSP info if available
let g:hackline_fileformat = 1
let g:hackline_encoding = 1
let g:hackline_filetype = 1
let g:hackline_filesize = 0
let g:hackline_wordcount = 0
let g:hackline_custom_end = '%( %P/%L %)'
```
