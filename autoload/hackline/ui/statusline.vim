function hackline#ui#statusline#set(status = v:false) abort
	let l:w = hackline#config#breakpoints()
	let l:active = a:status
	let l:hi = hackline#config#highlight_groups()
	" separator sections
	let l:sep = hackline#config#separators()
	" separator items
	let l:sep_i = '  '
	" length separator items
	let l:len_i = repeat(' ', strlen(l:sep_i))
	" inline padding
	let l:normal_px = repeat(' ', get(g:, 'hackline_normal_px', 2))
	" set initial highlight group (color)
	let l:line = ''
	let l:line .= l:active ? l:hi.start : l:hi.inactive

	" Statusline Left Side
	" --------------------

	if l:active && hackline#config#mode() && mode() != 'n'
		" modes
		let l:line .= hackline#ui#mode#info(l:len_i)
		let l:line .= l:len_i .. l:sep.l .. l:len_i
	else
		" ...or only inline padding
		let l:line .= l:normal_px
	endif
	" modified flag
	let l:line .= '%(%M' . l:len_i .. l:sep.l .. l:len_i . '%)'
	" buffern number
	let l:line .= '%(Buf %{bufnr()}%)'
	" filetype
	let l:line .= '%(' . l:sep_i . '%{&filetype}%)'
	" sep
	let l:line .= l:len_i .. l:sep.l
	" Truncation point
	let l:line .= l:len_i . '%<'
	let l:line .= '%(%{hackline#fileencoding#info()}%)'
	let l:line .= '%(' . l:sep_i . '%{&fileformat}%)'
	let l:line .= '%(' . l:sep_i . '%{hackline#ui#tab#info()}%)'
	let l:line .= '' . l:sep_i . '' . l:sep.l
	let l:line .= '%(' . l:sep_i .. hackline#config#cwd() . '%)'
	let l:line .= '' . l:sep_i . '' . l:sep.l
	let l:line .= '%(' . l:sep_i . '%{hackline#base#directories(' . l:w.xl . ')}%t%)'

	" Statusline Right Side
	" ---------------------

	let l:line .= '%='
	" Git
	if l:active
		if hackline#config#git_info() == 1
			" built in
			let l:line .= l:len_i .. hackline#ui#git#info()
		else
			" bring your own
			let l:line .= "%(" . l:len_i . "%{%hackline#config#git_info()%}"
		endif
	endif
	" Nvim LSP
	if l:active && hackline#config#nvim_lsp()
		let l:line .= hackline#ui#nvim_lsp#info(l:len_i, l:sep)
	endif
	" Vim LSP
	if l:active && hackline#config#vim_lsp()
		let l:line .= l:len_i .. l:sep.r .. l:len_i .. 'LSP'
	endif
	" Right side info
	if hackline#config#right() != ''
		let l:line .= l:len_i .. l:sep.r
		let l:line .= l:len_i . '%{%hackline#config#right()%}'
	endif
	" End spacing
	let l:line .= mode() == "n" ? l:normal_px : l:len_i

	return l:line
endfunction
