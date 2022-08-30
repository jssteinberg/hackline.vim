" active, hi, sep
function hackline#ui#bufnr#info(...) abort
	let l:statusline = ''

	" Show buffer number dependent on state/width
	if hackline#util#has_winwidth('md') && a:1
		let l:statusline .= '%( b' . a:2.mid_item . '%{bufnr()}' . a:2.mid . ' ' . a:3.l . '%)'
	else
		let l:statusline .= '%( b%{bufnr()}  %)'
	endif

	return l:statusline
endfunction
