if exists('g:loaded_hackline') | finish | endif
let g:loaded_hackline = v:true
let s:save_cpo = &cpo

set cpo&vim

" TODO: remove at some point
" echo "hackline.vim will get breaking changes (alt. use v1 branch)"
" echo "hackline.vim v2 has breaking changes (alt. use v1 branch)"

if &laststatus != 3 | exe('set laststatus=' . hackline#laststatus()) | endif
if hackline#mode() | set noshowmode | endif

aug init_hackline_statusline
	au!
	" BufReadPre to initially set inactive statusline
	au BufReadPre,WinLeave,FocusLost * setlocal statusline=%!hackline#statusline_nc()
	" CursorHold to set active for the often strangeness that is netrw
	au CursorHold,BufEnter,WinEnter,FocusGained * setlocal statusline=%!hackline#statusline()
	" Detect vim-lsp
	au User lsp_buffer_enabled let b:hackline_get_vim_lsp=1
	" Detect ALE
	au User ALEJobStarted let b:hackline_get_ale=1
aug END

let &cpo = s:save_cpo

unlet s:save_cpo
