function! hackline#ui#render(status = v:false) abort
	let l:active = a:status
	let l:hi = hackline#config#highlight_groups()
	" separator sections
	let l:sep = hackline#config#separators()
	" separator items
	let l:sep_i = get(g:, "hackline_sep_items", "  ")
	" length in spaces for item separator
	let l:len_i = repeat(' ', strlen(l:sep_i))
	" set initial highlight group (color)
	let l:line = ''
	let l:line .= l:active ? l:hi.start : l:hi.inactive

	" Statusline Left Side
	" --------------------

	if l:active && hackline#config#mode() && mode() != 'n'
		" mode not normal
		let l:line .= hackline#ui#mode#info(" ")
		" sep
		let l:line .= l:sep.l
	else
		let l:line .= " "
	endif
	" buffern number
	let l:line .= '%(Bufnr %{bufnr()}%)'
	" filetype
	let l:line .= '%(' . l:sep_i . '%{&filetype}%)'
	" sep
	let l:line .= l:sep.l
	" truncation point
	let l:line .= '%<'
	" encoding
	let l:line .= '%(%{hackline#fileencoding#info()}%)'
	" format
	let l:line .= '%(' . l:sep_i . '%{&fileformat}%)'
	" tabs/spaces
	let l:line .= '%(' . l:sep_i . '%{hackline#ui#tab#info()}%)'
	let l:line .= l:sep.l
	" Arglist length
	if argc()
		let l:line .= "Argc %{argc()}" .. l:sep.l
	endif
	" CWD
	if len(getcwd(0)) > 1
		let l:line .= '%(CD %{split(getcwd(0), "/")[-1]}%)'
	endif
	" Git
	let l:line .= hackline#ui#git#info(" *")
	let l:line .= l:sep.l
	" file path
	let l:line .= '%(%{hackline#ui#dir#info("xl")}%t%)'
	" modified flag
	let l:line .= '%( %m%)'

	" Statusline Right Side
	" ---------------------

	let l:line .= '%=' . l:len_i
	" Nvim LSP
	if l:active && has("nvim")
		let l:line .= hackline#ui#nvim_lsp#info("", l:sep.r)
	endif
	" Vim LSP
	if get(b:, "hackline_use_vim_lsp", "0") &&  l:active
		let l:line .= 'LSP' .. l:sep.r
	endif
	" Right side info
	let l:line .= "Line %l/%L Col %c"
	" End spacing
	let l:line .= " "

	return l:line
endfunction