function hackline#ui#statusline#set (status = v:false) abort
	let l:w = hackline#breakpoints()
	let l:active = a:status
	let l:labels = hackline#mode_labels()
	let l:hi = hackline#highlight_groups()
	" separator sections
	let l:sep = hackline#separators()
	" separator items
	let l:sep_i = '  '
	" length separator items
	let l:len_i = repeat(' ', strlen(l:sep_i))
	" Set initial highlight group (color)
	let l:line = ''
	let l:line .= l:active ? l:hi.start : l:hi.inactive

	" Statusline Left Side
	" --------------------

	if l:active && hackline#mode() && mode() != 'n'
		let l:line .= hackline#ui#mode#info(l:hi.modes, l:labels, l:len_i)
		let l:line .= l:len_i .. l:sep.l
	endif
	let l:line .= '%(' . l:sep_i . '%M' . l:len_i .. l:sep.l . '%)'
	let l:line .= '%(' . l:len_i . 'Buf %{bufnr()}%)'
	let l:line .= '%(' . l:sep_i . '%{&filetype}%)'
	let l:line .= l:len_i .. l:sep.l
	" Truncation point
	let l:line .= l:len_i . '%<'
	let l:line .= '%(%{hackline#fileencoding#info()}%)'
	let l:line .= '%(' . l:sep_i . '%{&fileformat}%)'
	let l:line .= '%(' . l:sep_i . '%{hackline#ui#tab#info()}%)'
	let l:line .= '' . l:sep_i . '' . l:sep.l
	let l:line .= '%(' . l:sep_i . '%{hackline#base#directories(' . l:w.xl . ')}%t%)'

	" Statusline Right Side
	" ---------------------

	let l:line .= '%='
	if l:active
		let l:line .= l:len_i .. hackline#ui#git#info()
	endif
	" Nvim LSP
	if l:active && hackline#nvim_lsp()
		let l:line .= hackline#ui#nvim_lsp#info(l:len_i, l:sep)
	endif
	" Vim LSP
	if l:active && hackline#vim_lsp()
		let l:line .= l:len_i .. l:sep.r .. l:len_i .. 'LSP'
	endif
	" Right side info
	if hackline#right() != ''
		let l:line .= l:len_i .. l:sep.r
		let l:line .= l:len_i . '%{%hackline#right()%}'
	endif
	let l:line .= l:len_i

	return l:line
endfunction
