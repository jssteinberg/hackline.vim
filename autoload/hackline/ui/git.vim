function! hackline#ui#git#info(append = "*", display_breakpoint = "md") abort
	" if append is string, use as append_left
	" if append is array, index 0 is append_left, index 1 is append_right
	if type(a:append) == v:t_string
		let l:append_left = a:append
		let l:append_right = ""
	elseif len(a:append)
		let l:append_left = a:append[0]
		if len(a:append) > 1
			let l:append_right = a:append[1]
		else
			let l:append_right = ""
		endif
	endif
	
	if hackline#util#has_winwidth(a:display_breakpoint)
		return ''
					\ . '%(' . l:append_left . '%{hackline#git#branch()}' . l:append_right . '%)'
					\ . '%(%{hackline#git#status()}%)'
	else
		return ''
	endif
endfunction
