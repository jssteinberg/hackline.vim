function hackline#ui#statusline#set (status = v:false) abort
	let l:w = hackline#breakpoints()
	let l:active = a:status
	let l:labels = hackline#mode_labels()
	let l:hi = hackline#highlight_groups()
	let l:sep = hackline#separators()
	let l:sep_i = '  '
	let l:line = l:sep_i . ' '

	" Statusline Left Side
	" --------------------

	" Set initial highlight group (color)
	let l:line .= l:active ? hackline#util#has_winwidth("md") ? l:hi.start : l:hi.active_sm : l:hi.inactive

	let l:line .= '%(#%{bufnr()}%)'
	let l:line .= '%(' . l:sep_i . '%{&filetype}%)'
	" let l:line .= ' ' . l:sep.l
	let l:line .= '%<'
	let l:line .= '%(' . l:sep_i . '%{hackline#fileencoding#info()}%)'
	let l:line .= '%(' . l:sep_i . '%{&fileformat}%)'
	let l:line .= '%(' . l:sep_i . '%{hackline#ui#tab#info()}%)'
	let l:line .= '' . l:sep_i . '' . l:sep.l
	let l:line .= '%(' . l:sep_i . '“%{hackline#base#directories(' . l:w.xl . ')}%t”%)'
	if l:active
		let l:line .= l:sep_i .. hackline#ui#git#info()
	endif

	" Statusline Middle (Right)
	" -------------------------

	let l:line .= '%='
	" Nvim LSP
	if l:active && hackline#nvim_lsp()
		let l:line .= hackline#ui#nvim_lsp#info(l:sep_i, l:sep)
	endif
	" Vim LSP
	if l:active && hackline#vim_lsp()
		let l:line .= l:sep_i .. l:sep.r .. l:sep_i .. 'LSP'
	endif

	" Statusline Right Side
	" ---------------------

	let l:line .= '%='
	if hackline#custom_end() != ''
		let l:line .= l:sep_i .. l:sep.r
		let l:line .= l:sep_i . '%{%hackline#custom_end()%}'
	endif
	let l:line .= '%(' . l:sep_i .. l:sep.r .. l:sep_i . '%M%)'
	if l:active && hackline#mode() && mode() != 'n'
		let l:line .= l:sep_i .. l:sep.r
		let l:line .= l:sep_i .. hackline#ui#mode#info(l:hi.modes, l:labels)
	endif

	let l:line .= l:sep_i . ' '

	return l:line
endfunction
