function! hackline#utils#getStsHis(his) abort
	for key in keys(a:his)
		if type(a:his[key]) == type({})
			let a:his[key] = hackline#utils#getStsHis(a:his[key])
		else
			let a:his[key] = a:his[key] != '' ? '%#'.a:his[key].'#' : ''
		endif
	endfor

	return a:his
endfunction
