![normal](https://user-images.githubusercontent.com/729055/178598591-5198524e-73e6-404e-a9fe-1ec5971d30bf.png)

# hackline.vim

*hackline.vim 'hacks' your statusline so you don't have to.*

A lightweight statusline plugin for Neovim (nvim) and Vim.
No setup or prerequisites required. Enjoy the simplicity! Yet it's quite fully featured, with some features through optional plugins.

- **No prerequisites** like icons or patched font, but there are simple variables for adding it.
- **Uses your colorscheme.** Uses already exisiting highlight groups, but can be customized if needed.
- **Minimal mode flag** for Vim professionals! Sets `noshowmode` if on---on by default.
- **Responsive**---adjusts statusline for smaller widths.
- **All buffer types** uses same settings---no specific buffer targeting. hackline.vim is just setup as dynamically as possible in how items are sorted and truncated, but still keeping them nice and logical for main buffers.

Integrations:

- **Git** info by using the one of the following plugins. hackline.vim connects in order: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [vim-fugitive](https://github.com/tpope/vim-fugitive), [vim-gitbranch](https://github.com/itchyny/vim-gitbranch). [VGit](https://github.com/tanvirtin/vgit.nvim) can supplement the two latter with Git status.
- **LSP** flag if connected to buffer. Supports [Neovim's LSP](https://github.com/neovim/nvim-lspconfig). And [vim-lsp](https://github.com/prabirshrestha/vim-lsp) (only simple flag if active LSP in buffer).

*Someone should confirm loading time. Low right?*

Default colors depends on your colorscheme. Here with [Iceberg](https://cocopon.github.io/iceberg.vim/) (note that the LSP info has improved a bit):

![insert](https://user-images.githubusercontent.com/729055/176217647-9c464f60-91d3-405f-8fc0-c66feaca1541.png)
![visual](https://user-images.githubusercontent.com/729055/176217668-2f5a1ccd-4f0a-469f-8912-fad630dd0e03.png)
![replace](https://user-images.githubusercontent.com/729055/176217697-f548262d-d277-4752-8419-b064d6e0df67.png)

*Why another statusline plugin?* hackline.vim is hacked to be the lightest statusline plugin for experienced Vim users, with no config needed for all features.
There's no patched font or icons dependency.

## Installation and Vim version 

<details>
<summary>packer.nvim Lua</summary>

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

</details>

<details>
<summary>Different Vim installs</summary>

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

Requires Neovim or Vim version > 8.2.1[something]---basically a newer version that supports re-evaluating expression results as a statusline format string.
For Mac, you can use Vim from Homebrew.

hackline.vim is tested on Neovim and Vim compiled with lua (but should work without Lua).

## Options

Global variables for simple customization.

Default values:

```vim
" Set option:
let g:hackline_laststatus = 2

" Toggle statusline info:
let g:hackline_mode = 1
let g:hackline_nvim_lsp = 1 " Native nvim LSP info if available
let g:hackline_vim_lsp = 1 " Vim LSP info if available

" Set separators and signs:
let g:hackline_separators = #{ l: '\', r: '/' }
let g:hackline_branch_sign = "*"
" For vgit
let g:hackline_git_signs = #{
			\added: "+",
			\removed: "-",
			\changed: "~",
			\}

" Set mode labels:
let g:hackline_label_command  = "Command"
let g:hackline_label_insert   = "Insert"
let g:hackline_label_terminal = "Terminal"
let g:hackline_label_visual   = "Visual"
let g:hackline_label_select   = "Select"
let g:hackline_label_replace  = "Replace"

" Set statusline value for the far right of the statusline:
let g:hackline_right = "Ln %l/%L Col %c"

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

![power](https://user-images.githubusercontent.com/729055/176217828-f5642220-9b6f-4306-a5f3-ec166eee31a9.png)

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

- Rm direct git plugin support, add support for bring-your-own Git info.
- mv separators to level based separators, e.g., "sep_inner" something.
- Add Vim help documentation.
- mode contextual information such as number of characters, words in visual selection.
- Nvim LSP number of buffer warning/errors?
- Support hi `StatusLineTerm` and `StatusLineTermNC`?
