if exists('g:loaded_hackline')
	finish
endif

let g:loaded_hackline = v:true
let s:save_cpo = &cpo

set cpo&vim

if &laststatus != 3
	exe('set laststatus=' . get(g:, 'hackline_laststatus', '2'))
endif

set statusline=%!hackline#statusline()

aug hackline_base
	au!
	" Set NC StatusLine
	au WinLeave,FocusLost * setlocal statusline=%!hackline#statusline()
	" Set StatusLine
	au WinEnter,BufWinEnter,FocusGained,BufFilePost * setlocal statusline=%!hackline#statusline(v:true)
	" Detect vim-lsp
	au User lsp_buffer_enabled let b:hackline_use_vim_lsp=1
aug END

if get(g:, "hackline_aggressive", 0)
	aug hackline_aggressive
		au!
		" Aggressively set StatusLine with CursorHold for the often strangeness that is netrw
		au CursorHold * setlocal statusline=%!hackline#statusline(v:true)
	aug END
endif

let &cpo = s:save_cpo

unlet s:save_cpo
