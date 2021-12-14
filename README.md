# hackline.vim

*Version 0.6---things may break.*

A minimalistic, light statusline for Vim and Neovim, embracing newer vanilla capabilities of (N)vim. Easy to copy and hack! Originally a fork of [skyline.vim](https://github.com/ourigen/skyline.vim).

![Skjermbilde 2021-12-12 kl  19 37 28](https://user-images.githubusercontent.com/729055/145725137-e9244f03-a1ad-49b9-8f91-42ff6d7f8a42.jpg)
![Skjermbilde 2021-12-12 kl  19 36 13](https://user-images.githubusercontent.com/729055/145725141-0f2b8ed2-72c0-4e3f-8b91-57c15cecfca0.jpg)
![Skjermbilde 2021-12-12 kl  19 36 55](https://user-images.githubusercontent.com/729055/145725144-76eedabc-5f63-4397-8aa0-c458fb56add4.jpg)

* No icons or need for patched font.
* Will look good with any newer colorscheme since it uses normal Vim highlight groups---no theme needed.
* Has good contrast for horizontal splits.
* Minimal mode flag for Vim professionals! (Sets `noshowmode` if on).
* Adjusts statusline for smaller widths.
* Sort statusline items for nicest truncation for most buffer types, without targeting specific buffer types.
* Word count module (from skyline.vim).
* File size module (from skyline.vim).

Plugins integrations:

* Displays git info by using the one of the following packages/plugins, in order: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [vim-gitbranch](https://github.com/itchyny/vim-gitbranch), [vim-fugitive](https://github.com/tpope/vim-fugitive).
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
let g:hackline_encoding = 1
let g:hackline_filetype = 1
let g:hackline_filesize = 0
let g:hackline_wordcount = 0
let g:hackline_custom_end = '%( %{&fileformat} %) %P/%L ' " Valid statusline value
```
