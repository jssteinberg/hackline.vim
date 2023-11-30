function! hackline#ui#git#info(append_left = "*", display_breakpoint = "md") abort
	if hackline#util#has_winwidth(a:display_breakpoint)
		return ''
					\ . '%(' . a:append_left . '%{hackline#git#branch()}%)'
					\ . '%( %{hackline#git#status()}%)'
	else
		return ''
	endif
endfunction
