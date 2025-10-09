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
- **Git** info is bring-your-own function (from a plugin usually), or falls back to the built-in support for one of the following plugins (though maintenance of plugin support can not be ensured) connected to in order: [vim-fugitive](https://github.com/tpope/vim-fugitive), [vim-gitbranch](https://github.com/itchyny/vim-gitbranch). [VGit](https://github.com/tanvirtin/vgit.nvim) can supplement the two latter with Git status. [Gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) can provide status summary numbers.

*Why another statusline plugin?*
Hackline.vim needs no customizing or no patched icon font. It’s not for the shallow, but hacked to be the lightest statusline plugin for pragmatic vimmers. In all honesty, the minimalism and barebones Vim features hackline.vim uses has drawbacks, but that’s worked around by hackline‘s design choices and are not really noticeable. Except the opinionated nature. The advantage is load time. Also, hackline.vim is generally fast.


## Installation

For lazy.nvim (Neovim Lua):

```lua
{
	"jssteinberg/hackline.vim",
	dependencies = "itchyny/vim-gitbranch",
	config = function()
		-- to disable cmdline mode flag
		vim.opt.showmode = false
	end,
}
```

<details>
<summary>More examples</summary>

```lua
-- packer example (Neovim Lua)
use {
	"jssteinberg/hackline.vim",
	requires = { "itchyny/vim-gitbranch" },
	config = function()
		-- disable command line mode flag
		vim.opt.showmode = false
	end
}
```

```vim
" minpac (vimscript)
call minpac#add('jssteinberg/hackline.vim')
```

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

Vimscript:

- `hackline#ui#dir#info()` -- params `min_breakpoint = "lg", max_breakpoint = "xl"` (possible values: `"md" | "lg" | "xl"`) -- returns current buffer relative directory, shortened between breakpoint, empty below `min_breakpoint`.
- `hackline#ui#git#info()` -- params `append = "*"` (string will be appended left; list will append values left then right), `display_breakpoint = "md"` (possible `display_breakpoint` values: `"md" | "lg" | "xl"`) -- returns git info from gitsigns, fugitive, vim-branch, or vgit.
- `hackline#ui#tab#info()` -- params `style = "max"` (use  `"min"` to truncate info) -- returns tabs or spaces, and their size.
- `hackline#ui#nvim_lsp#info()` -- params `append_left = " ", label = "LSP", preped_label = " ", seperator_servers = " ", prepend_right = " ", truncation_breakpoint = "xl"` (possible `truncation_breakpoint` values: `"md" | "lg" | "xl"`) -- returns LSP connected servers by name/length (above/below breakpoint)
- Also see `:help statusline`, https://jdhao.github.io/2019/11/03/vim_custom_statusline

Breakpoints can be redefined with `g:hackline_breakpoints`. E.g.:

```vim
" default
let g:hackline_breakpoints = #{
	md: 70, lg: 90, xl: 130
}
```

Number values refer to `winwidth(0)`. Note that breakpoints are ignored `if &laststatus == 3`.

For [vim-lsp](https://github.com/prabirshrestha/vim-lsp) there's a buffer local variable that tells if LSP is active:

```vim
if get(b:, "hackline_use_vim_lsp", "0")
	" LSP is active for buffer
endif
```

<details>
<summary>Full example</summary>

```vim
function! StatuslineModeLabels(sep_l = "", sep_r = "") abort
	if mode() == "i"     | return "I"
	elseif mode() == "c" | return "C"
	elseif mode() == "t" | return "T"
	elseif mode() == "r" | return "R"
	elseif mode() == "s" | return "S"
	else                 | return "V"
	endif
endfunction

function! Hackline(status) abort
	let l:active = a:status
	" separator label
	let l:sep_l = " "
	" separator sections
	let l:sep = #{l: "  --  ", r: "  /  "}
	" seperator secondary
	let l:sep_s = #{l: "  " , r: " "}
	" separator items
	let l:sep_i = #{l: " " , r: " "}

	" Statusline Start
	" ----------------
	let l:line = ""

	" set statusline default color
	let l:line .= l:active ? "%#StatusLine#" : "%#StatusLineNC#"
	" set some mode colors
	let l:line .= l:active && matchstr(mode(), "[itr]") != "" ? "%#IncSearch#" : ""
	" Start spacing
	let l:line .= " "

	if l:active && matchstr(mode(), "[nc]") == ""
		" (not normal or command mode)
		let l:line .= "%1(%{StatuslineModeLabels()}%)"
	else
		" modified flag, fixed width 1
		let l:line .= "%1(%M%)"
	endif

	" spacing
	let l:line .= " "

	" buffern number
	let l:line .= "%(:b%{bufnr()}%)"

	" filetype
	let l:line .= "%(" . l:sep_i.l . "%{&filetype}%)"

	let l:line .= l:sep.l

	" file path
	let l:line .= "%(%{hackline#ui#dir#info()}/%)"
	" filename
	let l:line .= "%(%t%)"

	let l:line .= l:sep.l

	" Cursor position
	let l:line .= "l-%l/%L c-%c"

	" Statusline END
	" --------------
	let l:line .= "%=" . l:sep_s.r

	" truncation point
	let l:line .= "%<"

	" vim lsp
	if l:active && get(b:, "hackline_use_vim_lsp", "0")
		let l:line .= "LSP" . l:sep.r
	endif

	" nvim LSP
	if l:active && has("nvim")
		let l:line .= hackline#ui#nvim_lsp#info("", "LSP", l:sep_l, l:sep_i.r, l:sep.r)
	endif

	" spelllang
	if l:active && &spell == 1
		let l:line .= "%(spl=%{&spelllang}" . l:sep_i.r . "%)"
	endif
	" tabs/spaces
	let l:line .= "%(%{hackline#ui#tab#info('min')}" . l:sep_i.r . "%)"
	" encoding
	let l:line .= "%(%{hackline#fileencoding#info()}%)"
	" format
	let l:line .= "%(" . l:sep_i.r . "%{&fileformat}%)"

	" CWD
	if len(getcwd(0)) > 1
		let l:line .= l:sep.r
		let l:line .= "%(%{split(getcwd(0), '/')[-1]}%)"
		" Git
		let l:line .= hackline#ui#git#info(" *")
	endif

	" End spacing
	let l:line .= "   "

	return l:line
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
