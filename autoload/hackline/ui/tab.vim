function hackline#ui#tab#info(truncate = 0) abort
	let l:info = !a:truncate ? 'tab ' : ''

	if &expandtab
		let l:info = !a:truncate ? 'expandtab ' : 'et '
	endif

	if shiftwidth() > 0 && shiftwidth() != &tabstop
		" Tabs but differing tabstop and shiftwidth vals = strangenest
		let l:info .= 'sw/ts '
		let l:info .= shiftwidth()
		let l:info .= '/'
		let l:info .= &tabstop
	elseif &expandtab
		let l:info .= shiftwidth()
	elseif &tabstop > 0
		let l:info .= 'ts='
		let l:info .= &tabstop
	endif

	return l:info
endfunction
