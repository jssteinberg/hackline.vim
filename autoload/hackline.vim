" Default config for hackline.vim

function hackline#highlight_groups() abort
	let l:highlight_groups = #{
				\ start: get(g:, "hackline_highlight_normal", "StatusLine"),
				\ modes: #{
				\   i:  get(g:, "hackline_highlight_insert",   "Todo"),
				\   v:  get(g:, "hackline_highlight_visual",   "PmenuSel"),
				\   vb: get(g:, "hackline_highlight_visual",   "PmenuSel"),
				\   r:  get(g:, "hackline_highlight_replace",  "IncSearch"),
				\   s:  get(g:, "hackline_highlight_select",   "IncSearch"),
				\   c:  get(g:, "hackline_highlight_command",  "DiffAdd"),
				\   t:  get(g:, "hackline_highlight_terminal", "DiffAdd"),
				\ },
				\ mid: 'Comment',
				\ mid_item: 'Normal',
				\ dir: 'Comment',
				\ tail: 'Normal',
				\ git: 'String',
				\ end: get(g:, "hackline_highlight_end", "StatusLine"),
				\ active_sm: get(g:, "hackline_highlight_normal", "StatusLine"),
				\ inactive: get(g:, "hackline_highlight_inactive", "StatusLineNC"),
				\ }

	return hackline#utils#getStatuslineHighlights( l:highlight_groups )
endfunction

function hackline#signature() abort
	let l:fallback_sign = has("nvim") ? "Neo" : "Vim"

	return get(g:, "hackline_sign", l:fallback_sign)
endfunction

function hackline#mode() abort
	return get(g:, "hackline_mode", "1")
endfunction

function hackline#filetype() abort
	return get(g:, "hackline_filetype", "1")
endfunction

function hackline#bufnum() abort
	return get(g:, "hackline_bufnum", "1")
endfunction

function hackline#ale() abort
	return get(g:, "hackline_ale", "0")
endfunction

function hackline#nvim_lsp() abort
	return get(g:, "hackline_nvim_lsp", "1")
endfunction

function hackline#vim_lsp() abort
	return get(g:, "hackline_vim_lsp", "1") && exists("b:hackline_get_vim_lsp")
endfunction

function hackline#git() abort
	return get(g:, "hackline_git", "1")
endfunction

function hackline#encoding() abort
	return get(g:, "hackline_encoding", "1")
endfunction

function hackline#fileformat() abort
	return get(g:, "hackline_fileformat", "1")
endfunction

function hackline#tab_info() abort
	return get(g:, "hackline_tab_info", "1")
endfunction

function hackline#custom_end() abort
	return get(g:, "hackline_custom_end", "
				\ %P/%L 
				\")
endfunction

function hackline#laststatus() abort
	return get(g:, 'hackline_laststatus', '2')
endfunction

function hackline#statusline() abort
	return hackline#statusline#val('active')
endfunction

function hackline#statusline_nc() abort
	return hackline#statusline#val()
endfunction
