" Returns statusline friendly highlight group values
function! hackline#utils#getStatuslineHighlights( his ) abort
	for key in keys(a:his)
		if type(a:his[key]) == type({})
			" recursion
			let a:his[key] = hackline#utils#getStatuslineHighlights( a:his[key] )
		else
			let a:his[key] = a:his[key] != '' ? '%#'.a:his[key].'#' : ''
		endif
	endfor

	return a:his
endfunction
