function! hackline#ui#git#info() abort
	if hackline#util#has_winwidth("md")
		return ''
					\ . '%( ' . hackline#config#branch_sign() . '%{hackline#git#branch()}%)'
					\ . '%( %{hackline#git#status()}%)'
	endif
endfunction
