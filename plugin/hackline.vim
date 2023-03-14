if exists('g:loaded_hackline')
	finish
endif

let g:loaded_hackline = v:true
let s:save_cpo = &cpo

set cpo&vim

if &laststatus != 3
	exe('set laststatus=' . get(g:, 'hackline_laststatus', '2'))
endif

aug init_hackline_statusline
	au!

	" Set NC StatusLine. BufReadPre to initially set inactive statusline
	au BufReadPre,WinLeave,FocusLost * setlocal statusline=%!hackline#statusline()

	" Set StatusLine
	au WinEnter,BufWinEnter,FocusGained,BufFilePost * setlocal statusline=%!hackline#statusline(v:true)
	" Set StatusLine. CursorHold to set active for the often strangeness that is netrw
	" au CursorHold,BufEnter,WinEnter,FocusGained * setlocal statusline=%!hackline#statusline(v:true)

	" Detect vim-lsp
	au User lsp_buffer_enabled let b:hackline_use_vim_lsp=1
aug END

let &cpo = s:save_cpo

unlet s:save_cpo
