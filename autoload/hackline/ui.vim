function! hackline#ui#render(status = v:false) abort
	let l:active = a:status
	" separator sections
	let l:sep = hackline#config#separators()
	" separator items
	let l:sep_i = get(g:, "hackline_sep_items", "  ")
	" length in spaces for item separator
	let l:len_i = repeat(' ', strlen(l:sep_i))
	" set initial highlight group (color)
	let l:line = ''
	let l:line .= l:active ? "%#StatusLine#" : "%#StatusLineNC#"

	" Statusline Left Side
	" --------------------

	if l:active && hackline#config#mode() && mode() != 'n'
		let l:line .= s:ShowMode("  ")
		" sep
		let l:line .= l:sep.l
	else
		let l:line .= "  "
	endif
	" buffern number
	let l:line .= '%(:b%{bufnr()}%)'
	" filetype
	let l:line .= '%(' . l:sep_i . '%{&filetype}%)'
	" sep
	let l:line .= l:sep.l
	" file path
	let l:line .= '%(%{hackline#ui#dir#info("xl")}/%)%t'
	" modified flag
	let l:line .= '%( %m%)'
	" sep
	let l:line .= l:sep.l
	" Cursor info
	let l:line .= "l-%l/%L c-%c"
	" truncation point
	let l:line .= l:len_i . '%<'

	" Statusline Right Side
	" ---------------------

	let l:line .= '%='
	" let l:line .= '%(%{codeium#GetStatusString()} AI' . l:sep.r . '%)'
	" Nvim LSP
	if l:active && has("nvim")
		let l:line .= hackline#ui#nvim_lsp#info("", "LSP", " ", " ", l:sep.r)
	endif
	" Vim LSP
	if get(b:, "hackline_use_vim_lsp", "0") &&  l:active
		let l:line .= 'LSP' .. l:sep.r
	endif
	" spelllang
	if l:active && &spell == 1
		let l:line .= "%(spl=%{&spelllang}" . l:sep_i . "%)"
	endif
	" tabs/spaces
	let l:line .= '%(%{hackline#ui#tab#info()}' . l:sep_i . '%)'
	" encoding
	let l:line .= '%(%{hackline#fileencoding#info()}%)'
	" format
	let l:line .= '%(' . l:sep_i . '%{&fileformat}%)'
	" CWD
	if len(getcwd(0)) > 1
		let l:line .= l:sep.r
		let l:line .= '%(%{split(getcwd(0), "/")[-1]}%)'
		" Git
		let l:line .= hackline#ui#git#info(" *")
	endif
	" End spacing
	let l:line .= "  "

	return l:line
endfunction

function! s:ShowMode(sep_l = "", sep_r = "") abort
	if mode() == "i"     | return "%#IncSearch#" . a:sep_l . "I" . a:sep_r
	elseif mode() == "c" | return a:sep_l . "C" . a:sep_r
	elseif mode() == "t" | return "%#IncSearch#" . a:sep_l . "T" . a:sep_r
	elseif mode() == "r" | return "%#IncSearch#" . a:sep_l . "R" . a:sep_r
	elseif mode() == "s" | return "%#IncSearch#" . a:sep_l . "S" . a:sep_r
	else                 | return "%#IncSearch#" . a:sep_l . "V" . a:sep_r
	endif
endfunction

