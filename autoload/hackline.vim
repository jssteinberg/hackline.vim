" Default config for hackline.vim

function! hackline#statusline(active = v:false) abort
	if exists("*Hackline")
		return Hackline(a:active)
	else
		return hackline#ui#statusline(a:active)
	endif
endfunction

function! hackline#init() abort
	aug init_hackline_statusline
		au!
		" BufReadPre to initially set inactive statusline
		au BufReadPre,WinLeave,FocusLost * setlocal statusline=%!hackline#statusline()
		" CursorHold to set active for the often strangeness that is netrw
		au CursorHold,BufEnter,WinEnter,FocusGained * setlocal statusline=%!hackline#statusline(v:true)
		" Detect vim-lsp
		au User lsp_buffer_enabled let b:hackline_get_vim_lsp=1
	aug END
endfunction
