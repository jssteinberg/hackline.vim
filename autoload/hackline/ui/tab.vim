" Optional string parmater `style` ["min"|"max"]
function! hackline#ui#tab#info(style = "max") abort
	let l:info = ''
	let l:truncate = a:style == "min"

	if &expandtab
		let l:info = !l:truncate ? 'expandtab ' : ''
	else
		let l:info = !l:truncate ? 'tab ' : ''
	endif

	if shiftwidth() > 0 && shiftwidth() != &tabstop
		" Differing tabstop and shiftwidth is not good
		let l:info .= 'sw/ts='
		let l:info .= shiftwidth()
		let l:info .= '/'
		let l:info .= &tabstop
	elseif &expandtab
		" Spaces
		let l:info .= !l:truncate ? 'sw=' : ''
		let l:info .= shiftwidth()
	elseif &tabstop > 0
		" Tab indent size
		let l:info = !l:truncate ? 'tabstop=' : 'ts='
		let l:info .= &tabstop
	endif

	return l:info
endfunction
