function! hackline#ui#tab#info(truncate = 0) abort
	let l:info = ''

	if &expandtab
		let l:info = 'expandtab '
	else
		let l:info = 'tab '
	endif

	if shiftwidth() > 0 && shiftwidth() != &tabstop
		" Differing tabstop and shiftwidth is not good
		let l:info .= 'sw/ts='
		let l:info .= shiftwidth()
		let l:info .= '/'
		let l:info .= &tabstop
	elseif &expandtab
		let l:info .= !a:truncate ? 'sw=' : ''
		let l:info .= shiftwidth()
	elseif &tabstop > 0
		let l:info = 'tabstop='
		let l:info .= &tabstop
	endif

	return l:info
endfunction
