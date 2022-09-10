function hackline#ui#tab#info(truncate = 0) abort
	let l:info = !a:truncate ? 'tabs' : 'tabs'

	if &expandtab
		let l:info = !a:truncate ? 'expandtab(sw=' : 'et/sw='
		let l:info .= shiftwidth()
	elseif shiftwidth() > 0 && shiftwidth() != &tabstop
		" Tabs but differing tabstop and shiftwidth vals = strangenest
		let l:info = 'ts='
		let l:info .= &tabstop
		let l:info .= '/sw=' . shiftwidth()
	elseif &tabstop > 0
		let l:info = !a:truncate ? 'tabs/ts=' : 'ts='
		let l:info .= &tabstop
	endif

	return l:info
endfunction
