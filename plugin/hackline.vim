if exists('g:loaded_hackline') | finish | endif
let g:loaded_hackline = v:true

let s:save_cpo = &cpo
set cpo&vim

" Global vars for some customization
let g:hackline_signature = get(g:, 'hackline_signature', '')
let g:hackline_mode = get(g:, 'hackline_mode', '1')
let g:hackline_bufnum = get(g:, 'hackline_bufnum', '1')
let g:hackline_filetype = get(g:, 'hackline_filetype', '1')
let g:hackline_ale = get(g:, 'hackline_ale', '0')
let g:hackline_nvim_lsp = get(g:, 'hackline_nvim_lsp', '1')
let g:hackline_vim_lsp = get(g:, 'hackline_vim_lsp', '0')
let g:hackline_git = get(g:, 'hackline_git', '1')
let g:hackline_encoding = get(g:, 'hackline_encoding', '1')
let g:hackline_fileformat = get(g:, 'hackline_fileformat', '1')
let g:hackline_tab_info = get(g:, 'hackline_tab_info', '1')
let g:hackline_custom_end = get(g:, 'hackline_custom_end', '
			\ %P/%L 
			\')

aug hackline
	au!
	" BufReadPre to initially set inactive statusline
	au BufReadPre,WinLeave,FocusLost * setlocal statusline=%!hackline#statusline#val()
	" CursorHold to set active for the often strangeness that is netrw
	au CursorHold,BufEnter,WinEnter,FocusGained * setlocal statusline=%!hackline#statusline#val('active')
	au User lsp_buffer_enabled let b:hackline_get_vim_lsp=1
	au User ALEJobStarted let b:hackline_get_ale=1
aug END

set laststatus=2
if g:hackline_mode | set noshowmode | endif

let &cpo = s:save_cpo
unlet s:save_cpo
