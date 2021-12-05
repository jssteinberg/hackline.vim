# hackline.vim

<img width="951" alt="Skjermbilde 2021-12-05 kl  22 03 09" src="https://user-images.githubusercontent.com/729055/144764748-1cb3d1a6-9ade-4915-a973-cc9d0338b4fb.png">
<img width="1416" alt="Skjermbilde 2021-12-05 kl  22 31 42" src="https://user-images.githubusercontent.com/729055/144764795-bf2a5252-7079-4f68-85e4-453de959e4e9.png">

*Version 0.2---things may break.*

An opinionated statusline. Easy to copy and hack. Originally a fork of [skyline.vim](https://github.com/ourigen/skyline.vim).

* Minimal mode flag for Vim professionals! (Sets `noshowmode` if on).
* No themes available or needed---uses usual Vim highlight groups. Has good contrast for horizontal splits.
* No icons or need for patched font.
* Word count modules (from skyline.vim), nice for writers.
* Adjusts for narrow windows.

Plugins integrations:

* A git branch module (from skyline.vim), supported by [vim-fugitive](https://github.com/tpope/vim-fugitive).
* Shows connected Neovim LSP.
* Shows if ALE is active and number of error/warnings.

## Installation

Requires a newer version of Vim > 8.2.1... or Neovim. Basically a version that can re-evaluated results of an expression as a statusline format string. **Not tested on Vims without lua.** On Macos, Vim from Homebrew works.

Vim [vim-plug](https://github.com/junegunn/vim-plug) installation:

```
Plug 'jssteinberg/hackline.vim'
```

## Options

Global variables for simple customization.

Default values:

```vim
let g:hackline_bufnum = 1
let g:hackline_mode = 1
let g:hackline_fugitive = 1 " Displays branch if fugitive is loaded
let g:hackline_ale = 1 " ALE info if available
let g:hackline_nvim_lsp = 1 " Native nvim LSP info if available
let g:hackline_fileformat = 1
let g:hackline_encoding = 1
let g:hackline_filetype = 1
let g:hackline_filesize = 0
let g:hackline_wordcount = 0
let g:hackline_custom_end = '%( %p%%/%L %)'
```
