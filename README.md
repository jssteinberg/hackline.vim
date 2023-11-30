# hackline.vim

*hackline.vim 'hacks' your statusline so you don't have to.*

An opinionated minimalistic statusline plugin for Vim and Neovim. It's lightweight, loads in no-time, still quite fully featured, with some features through optional plugins.

- **No prerequisites** like patched icon fonts. It has simple options for changing separators.
- **Supports any colorscheme** by being a normal Vim statusline. Highlight groups can be changed per mode, but changes the entire statusline for its context.
- **Mode flag** when not normal mode. Minimal by default.
- **Responsive design** adjusts and truncates on priority for smaller widths.
- **All buffers** uses same settings. No bloat with specific buffer/file type targeting. hackline.vim is just setup as dynamically as possible in how items are sorted and truncated, but still keeping them nice and logical for main buffers.

Integrations:

- **LSP** flag if connected to buffer. Supports [Neovim's LSP](https://github.com/neovim/nvim-lspconfig). And [vim-lsp](https://github.com/prabirshrestha/vim-lsp) (only simple flag if active LSP in buffer).
- **Git** info is bring-your-own function (from a plugin usually), or falls back to the built-in support for one of the following plugins (though maintenance of plugin support can not be ensured) connected to in order: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [vim-fugitive](https://github.com/tpope/vim-fugitive), [vim-gitbranch](https://github.com/itchyny/vim-gitbranch). [VGit](https://github.com/tanvirtin/vgit.nvim) can supplement the two latter with Git status.

*Why another statusline plugin?*
Hackline.vim needs no customizing or no patched icon font. It’s not for the shallow, but hacked to be the lightest statusline plugin for pragmatic vimmers. In all honesty, the minimalism and barebones Vim features hackline.vim uses has drawbacks, but that’s worked around by hackline‘s design choices and are not really noticeable. Except the opinionated nature. The advantage is load time. Also, hackline.vim is generally fast.


## Installation

Neovim example with packer.nvim:

```lua
use {
	"jssteinberg/hackline.vim",
	requires = { "itchyny/vim-gitbranch" },
	config = function()
		-- disable command line mode flag
		vim.opt.showmode = false
	end
}
```

<details>
<summary>For Vim</summary>

```vim
" minpac
call minpac#add('jssteinberg/hackline.vim')
```

(And it should be equally simple with vim-plug).

</details>

hackline.vim requires Neovim or Vim version > 8.2.1[something]---basically a newer version that supports re-evaluating expression results as a statusline format string.
For Mac, you can use Vim from Homebrew.

hackline.vim is tested on Neovim and Vim compiled with lua (but should work without Lua).


## Options

Global variables for simple customization. Default values:

```vim
" Options:
let g:hackline_laststatus = 2 " corresponds to `laststatus`
let g:hackline_aggressive = 0 " or 1 for aggressive rerendering of statusline

" Items:
let g:hackline_mode = 1 " To activate mode flags and not deactivating `showmode`

" Separators and signs:
let g:hackline_separators = #{ l: '  /  ', r: '  /  ' }
" for vgit
let g:hackline_git_signs = #{
			\added: "+",
			\removed: "-",
			\changed: "~",
			\}
```

### Further customize

For full customization define your global Hackline function to customize.

```vim
function! Hackline(status) abort
	return ""
endfunction
```

#### Hackline provided functions

- `hackline#ui#dir#info()` -- params `breakpoint = "xl"` (possible values: `"md" | "lg" | "xl"`) -- returns current buffer relative directory, shortened below breakpoint.
- `hackline#ui#git#info()` -- params `append_left = "*", display_breakpoint = "md"` (possible `display_breakpoint` values: `"md" | "lg" | "xl"`) -- returns git info from gitsigns, fugitive, vim-branch, or vgit.
- `hackline#ui#tab#info()` -- params `style = "max"` (use  `"min"` to truncate info) -- returns tabs or spaces, and their size.
- `hackline#ui#nvim_lsp#info()` -- params `append_left = " ", label = "LSP", preped_label = " ", seperator_servers = " ", prepend_right = " ", truncation_breakpoint = "xl"` (possible `truncation_breakpoint` values: `"md" | "lg" | "xl"`) -- returns LSP connected servers by name/length (above/below breakpoint)
- Also see `:help statusline`


<details>
<summary>Full example</summary>

```vim
function! Hackline(status) abort
	let l:active = a:status
	" separator sections
	let l:sep = #{l: " ", r: " "}
	" separator items
	let l:sep_i = "/"
	" length in spaces for separators
	let l:len_l = repeat(" ", strlen(l:sep.l))
	let l:len_i = repeat(" ", strlen(l:sep_i))

	" Statusline Left Side
	" --------------------

	let l:line = ""
	" set statusline default color
	let l:line .= l:active ? "%#StatusLine#" : "%#StatusLineNC#"
	" set mode style
	if l:active && mode() != "n"
		let l:line .= s:ShowMode()
	endif
	let l:line .= " "
	" modified flag
	let l:line .= "%(%M" . l:sep_i . "%)"
	" buffern number
	let l:line .= "%(b%{bufnr()}%)"
	" filetype
	let l:line .= "%(" . l:sep_i . "%{&filetype}%)"
	" filename
	let l:line .= "%(: %t%)"
	" CWD
	if len(getcwd(0)) > 1
		let l:line .= " ("
		" truncation point
		let l:line .= "%<"
		let l:line .= "%(%{split(getcwd(0), '/')[-1]}%)"
		" Git
		let l:line .= hackline#ui#git#info("*")
		" file path
		let l:line .= "%(, %{hackline#ui#dir#info('xl')}%)"
		let l:line .= ")"
		" sep l
		let l:line .= l:sep.l
	else
		" truncation point
		let l:line .= l:sep.l . "%<"
	endif
	" spelllang
	if l:active && &spell == 1
		let l:line .= "%(%{&spelllang}" . l:sep_i . "%)"
	endif
	" encoding
	let l:line .= "%(%{hackline#fileencoding#info()}%)"
	" format
	let l:line .= "%(" . l:sep_i . "%{&fileformat}%)"
	" tabs/spaces
	let l:line .= "%(" . l:sep_i . "%{hackline#ui#tab#info('min')}%)"
	" Nvim LSP
	if l:active && has("nvim")
		let l:line .= hackline#ui#nvim_lsp#info(l:sep.l, "LSP", l:sep_i, l:sep_i, l:len_l)
	endif
	" Vim LSP
	if l:active && get(b:, "hackline_use_vim_lsp", "0")
		let l:line .= l:sep.l . "LSP" . l:len_i
	endif

	" Statusline Right Side
	" ---------------------
	let l:line .= "%=" . l:len_i

	" Cursor position
	let l:line .= "Line %l/%L Col %c"
	" End spacing
	let l:line .= " "

	return l:line
endfunction

function! s:ShowMode(sep_l = "", sep_r = "") abort
	if mode() == "i"     | return "%#IncSearch#"
	elseif mode() == "c" | return "%#IncSearch#"
	elseif mode() == "t" | return "%#IncSearch#"
	elseif mode() == "r" | return "%#IncSearch#"
	elseif mode() == "s" | return "%#IncSearch#"
	else                 | return "%#IncSearch#"
	endif
endfunction
```

</details>


## About development

This is v4.0.0-0.

Originally a fork of the lightweight [skyline.vim](https://github.com/ourigen/skyline.vim) which has a different look.

### *Future*

- Highlight group for unsaved
- Add Vim help documentation.
- Visual mode contextual information such column/line range, words in visual selection, etc.
- Nvim LSP number of buffer warning/errors?
