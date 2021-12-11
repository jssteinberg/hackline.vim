# hackline.vim

*Version 0.6---things may break.*

A light statusline for Vim and Neovim, embracing newer vanilla capabilities of the fabled editor. Easy to copy and hack! Originally a fork of [skyline.vim](https://github.com/ourigen/skyline.vim).

* Minimal mode flag for Vim professionals! (Sets `noshowmode` if on).
* No themes available or needed---uses usual Vim highlight groups. Has good contrast for horizontal splits.
* Adjusts statusline for smaller widths.
* Sort statusline items for nicest truncation for most buffer types, without targeting specific buffer types.
* No icons or need for patched font.
* Word count module (from skyline.vim).
* File size module (from skyline.vim).

Plugins integrations:

* Will display git info by looking for plugins in order: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [vim-gitbranch](https://github.com/itchyny/vim-gitbranch), [vim-fugitive](https://github.com/tpope/vim-fugitive).
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
