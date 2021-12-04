# hackline.vim

*An opinionated statusline (in beta---things may break) for grownups. Easy to copy and hack. Originally a fork of [skyline.vim](https://github.com/ourigen/skyline.vim).*

* Minimal mode flag for pros, or turn it off and use native showmode.
* No themes available or needed---uses usual Vim highlight groups. Has good contrast for horizontal splits.
* No icons or need for patched font.
* Word and line count modules (from skyline.vim), nice for writers.

Plugins integrations:

* A git branch module (from skyline.vim), supported by [vim-fugitive](https://github.com/tpope/vim-fugitive).
* Shows buffer-active ALE linters.

Much slimmer alternatives to plugins like [powerline](https://github.com/powerline/powerline), [vim-airline](https://github.com/vim-airline/vim-airline), or [lightline.vim](https://github.com/itchyny/lightline.vim). But, of course, it is not as feature-packed.

## Installation

Requires a new version of Vim 8.2 or Neovim that can re-evaluated results of an expression as a statusline format string. On Macos use Vim from Homebrew. Install with `brew install vim`.

Vim [vim-plug](https://github.com/junegunn/vim-plug) installation:

```
Plug 'jssteinberg/hackline.vim'
```

Or for Neovim with [packer.nvim](https://github.com/wbthomason/packer.nvim):

```vim
use {'jssteinberg/hackline.vim'}
```

## Options

Global variables to customize. Default:

```vim
let g:hackline_bufnum = 1
let g:hackline_path = 1 " 0 = tail, 1 = path
let g:hackline_mode = 1
let g:hackline_fugitive = 1 " Displays branch if fugitive is loaded
let g:hackline_fileformat = 1
let g:hackline_encoding = 1
let g:hackline_filetype = 1
let g:hackline_filesize = 0
let g:hackline_wordcount = 0
let g:hackline_linecount = 0
let g:hackline_percent = 1
let g:hackline_lineinfo = 0
```
