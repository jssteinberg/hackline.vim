" Default config for hackline.vim

function! hackline#statusline(active = v:false) abort
	if exists("*Hackline")
		return Hackline(a:active)
	else
		return hackline#ui#render(a:active)
	endif
endfunction
