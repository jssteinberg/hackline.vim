" active, sep, hi
function hackline#ui#git#info(...) abort
	if a:1 && hackline#util#has_winwidth("md")
		return ''
					\ . '%('.a:2.r.' ' . a:3.mid_item..hackline#branch_sign()..a:3.branch.'%{hackline#git#branch()}'.a:3.mid.'%)'
					\ . '%(('.a:3.mid_item.'%{hackline#git#status()}'.a:3.mid.')%) '
	else
		return ''
	endif
endfunction
