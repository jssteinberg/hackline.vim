function! hackline#ui#statusline#set(status = v:false) abort
	let l:w = hackline#config#breakpoints()
	let l:active = a:status
	let l:hi = hackline#config#highlight_groups()
	" separator sections
	let l:sep = hackline#config#separators()
	" separator items
	let l:sep_i = get(g:, "hackline_sep_items", "  ")
	" length separator items/inline
	let l:len_i = repeat(' ', strlen(l:sep_i))
	" inline padding
	let l:normal_px = repeat(' ', get(g:, 'hackline_normal_px', 2))
	" set initial highlight group (color)
	let l:line = ''
	let l:line .= l:active ? l:hi.start : l:hi.inactive

	" Statusline Left Side
	" --------------------

	if l:active && hackline#config#mode() && mode() != 'n'
		" mode not normal
		let l:line .= hackline#ui#mode#info(l:len_i)
		" sep
		let l:line .= l:sep.l
	else
		" ...or only inline padding
		let l:line .= l:normal_px
	endif
	" buffern number
	let l:line .= '%(Buf %{bufnr()}%)'
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
	" CWD
	let l:line .= !get(g:, "hackline_cwd", v:false)
				\ ? l:sep.il
				\ : len(getcwd()) > 1
				\ ? l:sep.l . "%(%{split(getcwd(), '/')[-1]}" . l:sep.il . "%)"
				\ : l:sep.l
	" file path
	let l:line .= '%(%{hackline#base#directories(' . l:w.xl . ')}%t%)'
	" modified flag
	let l:line .= '%( %m%)'

	" Statusline Right Side
	" ---------------------

	let l:line .= '%='
	" Git
	if l:active
		if hackline#config#git_info() == 1
			" built in
			let l:line .= hackline#ui#git#info()
		else
			" bring your own
			let l:line .= "%( %{%hackline#config#git_info()%}"
		endif
	endif
	" Nvim LSP
	if l:active && hackline#config#nvim_lsp()
		let l:line .= hackline#ui#nvim_lsp#info(l:sep.r)
	endif
	" Vim LSP
	if l:active && hackline#config#vim_lsp()
		let l:line .= l:sep.r .. 'Lsp'
	endif
	" Right side info
	if hackline#config#right() != ''
		try
			let l:line .= l:sep.r
			let l:line .= '%{%hackline#config#right()%}'
		catch | endtry
	endif
	" End spacing
	let l:line .= mode() == "n" ? l:normal_px : l:len_i

	return l:line
endfunction
