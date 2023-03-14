function! hackline#ui#git#info(sep_l = "*", sep_r = "", breakpoint = "md") abort
	if hackline#util#has_winwidth("md")
		return ''
					\ . '%(' . a:sep_l . '%{hackline#git#branch()}%)'
					\ . '%( %{hackline#git#status()}%)'
	else
		return ''
	endif
endfunction
