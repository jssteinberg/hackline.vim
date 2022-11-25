" Default config for hackline.vim

function! hackline#init() abort
	aug init_hackline_statusline
		au!
		" BufReadPre to initially set inactive statusline
		au BufReadPre,WinLeave,FocusLost * setlocal statusline=%!hackline#ui#statusline#set()
		" CursorHold to set active for the often strangeness that is netrw
		au CursorHold,BufEnter,WinEnter,FocusGained * setlocal statusline=%!hackline#ui#statusline#set(v:true)
		" Detect vim-lsp
		au User lsp_buffer_enabled let b:hackline_get_vim_lsp=1
	aug END
endfunction
