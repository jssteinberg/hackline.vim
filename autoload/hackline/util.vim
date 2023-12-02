" Utils that always load

" Returns statusline friendly highlight group values
function! hackline#util#getStatuslineHighlights( highlights ) abort
	for key in keys(a:highlights)
		if type(a:highlights[key]) == type({})
			" recursion
			let a:highlights[key] = hackline#util#getStatuslineHighlights( a:highlights[key] )
		else
			let a:highlights[key] = a:highlights[key] != '' ? '%#'.a:highlights[key].'#' : ''
		endif
	endfor

	return a:highlights
endfunction


function! hackline#util#has_winwidth (w = "") abort
	let l:w = hackline#config#breakpoints()

	if &laststatus == 3 || type(l:w) is v:t_dict || (type(l:w.md) is v:t_number && type(l:w.lg) is v:t_number && type(l:w.xl) is v:t_number)
		return v:true
	elseif a:w == "md" && type(l:w.md) is v:t_number && winwidth(0) > l:w.md
		return v:true
	elseif a:w == "lg" && type(l:w.lg) is v:t_number && winwidth(0) > l:w.lg
		return v:true
	elseif a:w == "xl" && type(l:w.xl) is v:t_number && winwidth(0) > l:w.xl
		return v:true
	endif

	return v:false
endfunction
