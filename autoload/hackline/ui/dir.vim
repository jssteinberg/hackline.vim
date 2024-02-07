function! hackline#ui#dir#info(min_breakpoint = "lg", max_breakpoint = "xl") abort
	" relative path without filename
	let l:path = expand('%:p:.:h')

	if l:path == '.' || l:path == ''
		return ''
	endif

	if hackline#util#has_winwidth(a:max_breakpoint)
		return l:path
	elseif hackline#util#has_winwidth(a:min_breakpoint)
		return pathshorten(l:path)
	else
		return ''
	endif
endfunction
