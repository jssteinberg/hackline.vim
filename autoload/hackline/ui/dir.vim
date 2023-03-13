function! hackline#ui#dir#info(breakpoint = "xl") abort
	let l:path = expand('%:p:.:h')

	if hackline#util#has_winwidth(a:breakpoint)
		let l:path = pathshorten(l:path)
	endif

	if l:path !=# '.' && l:path !=# ''
		return l:path == '/' ? l:path : l:path.'/'
	endif

	return ''
endfunction
