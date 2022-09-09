" active, sep, hi
function hackline#ui#git#info(...) abort
	if a:1 && hackline#util#has_winwidth("md")
		return ''
					\ . '%(' . hackline#branch_sign() . '%{hackline#git#branch()}%)'
					\ . '%( %{hackline#git#status()} %)'
	else
		return ''
	endif
endfunction
