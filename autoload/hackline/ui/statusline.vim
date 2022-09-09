function hackline#ui#statusline#set (status = v:false) abort
	let l:w = hackline#breakpoints()
	let l:active = a:status
	let l:labels = hackline#mode_labels()
	let l:hi = hackline#highlight_groups()
	let l:sep = hackline#separators()

	let l:line=' '

	" Statusline Left Side
	" --------------------

	" Set initial highlight group (color)
	let l:line .= l:active ? hackline#util#has_winwidth("md") ? l:hi.start : l:hi.active_sm : l:hi.inactive

	let l:line .= '%( #%{bufnr()}%)'
	let l:line .= '%( %{&filetype}%)'
	let l:line .= ' ' . l:sep.l
	let l:line .= '%<'
	let l:line .= '%( %{hackline#fileencoding#info()}%)'
	let l:line .= '%( %{&fileformat}%)'
	let l:line .= ' ' . l:sep.l
	let l:line .= '%( “%{hackline#base#directories('.l:w.xl.')}%t%)”'
	if l:active && hackline#git()
		let l:line .= ' ' . l:sep.l
		let l:line .= ' ' . hackline#ui#git#info(l:active)
	endif

	" Statusline Right Side
	" ---------------------

	let l:line .= ' %='
	" Nvim LSP
	if hackline#nvim_lsp()
		let l:line .= hackline#ui#nvim_lsp#info(l:active, l:hi, l:sep)
	endif
	" Vim LSP
	if l:active && hackline#vim_lsp()
		let l:line .= l:sep.r.' LSP'
	endif
	let l:line .= ' %='

	if hackline#custom_end() != ''
		let l:line .= ' ' . l:sep.r
		let l:line .= ' %{%hackline#custom_end()%}'
	endif

	let l:line .= '%( ' . l:sep.r . ' %M%)'

	if l:active && hackline#mode() && mode() != 'n'
		let l:line .= ' ' . l:sep.r
		let l:line .= hackline#ui#mode#info(l:hi.modes, l:labels)
	endif

	let l:line .= '  '

	return l:line
endfunction
