" Default config for hackline.vim
" TODO: Move all default config to this file...

function! hackline#highlight_groups()
	let l:highlight_groups = #{
				\ start: get(g:, "hackline_highlight_normal", "StatusLine"),
				\ modes: #{
				\   c:  get(g:, "hackline_highlight_command",  "Todo"),
				\   i:  get(g:, "hackline_highlight_insert",   "DiffAdd"),
				\   t:  get(g:, "hackline_highlight_terminal", "Todo"),
				\   v:  get(g:, "hackline_highlight_visual",   "PmenuSel"),
				\   vb: get(g:, "hackline_highlight_visual",   "PmenuSel"),
				\   r:  get(g:, "hackline_highlight_replace",  "IncSearch"),
				\   s:  get(g:, "hackline_highlight_select",   "IncSearch"),
				\ },
				\ mid: 'Comment',
				\ mid_item: 'Normal',
				\ dir: 'Comment',
				\ tail: 'Normal',
				\ git: 'String',
				\ end: 'StatusLine',
				\ active_sm: get(g:, "hackline_highlight_normal", "StatusLine"),
				\ inactive: 'StatusLineNC'
				\ }

	return hackline#utils#getStatuslineHighlights( l:highlight_groups )
endfunction

function! hackline#signature()
	let l:fallback_sign = has("nvim") ? "Neo" : "Vim"

	return get(g:, "hackline_sign", l:fallback_sign)
endfunction

function! hackline#mode()
	return get(g:, "hackline_mode", "1")
endfunction

function! hackline#filetype()
	return get(g:, "hackline_filetype", "1")
endfunction

function! hackline#bufnum()
	return get(g:, "hackline_bufnum", "1")
endfunction

function! hackline#ale()
	return get(g:, "hackline_ale", "0")
endfunction

function! hackline#nvim_lsp()
	return get(g:, "hackline_nvim_lsp", "1")
endfunction

function! hackline#vim_lsp()
	return get(g:, "hackline_vim_lsp", "1") && exists("b:hackline_get_vim_lsp")
endfunction

function! hackline#git()
	return get(g:, "hackline_git", "1")
endfunction

function! hackline#encoding()
	return get(g:, "hackline_encoding", "1")
endfunction

function! hackline#fileformat()
	return get(g:, "hackline_fileformat", "1")
endfunction

function! hackline#tab_info()
	return get(g:, "hackline_tab_info", "1")
endfunction

function! hackline#custom_end()
	return get(g:, "hackline_custom_end", "
				\ %P/%L 
				\")
endfunction

function! hackline#laststatus()
	return get(g:, 'hackline_laststatus', '2')
endfunction
