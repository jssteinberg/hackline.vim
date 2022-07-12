" Default config for hackline.vim

function hackline#highlight_groups() abort
	let l:highlight_groups = #{
				\ start: get(g:, "hackline_highlight_normal", "StatusLine"),
				\ mod: get(g:, "hackline_highlight_modified", hackline#modified() == 2 ? "Search" : "Normal"),
				\ modes: #{
				\   i:  get(g:, "hackline_highlight_insert",   "Todo"),
				\   v:  get(g:, "hackline_highlight_visual",   "PmenuSel"),
				\   vb: get(g:, "hackline_highlight_visual",   "PmenuSel"),
				\   r:  get(g:, "hackline_highlight_replace",  "IncSearch"),
				\   s:  get(g:, "hackline_highlight_select",   "IncSearch"),
				\   c:  get(g:, "hackline_highlight_command",  "DiffAdd"),
				\   t:  get(g:, "hackline_highlight_terminal", "DiffAdd"),
				\ },
				\ mid: get(g:, "hackline_highlight_secondary", "Comment"),
				\ mid_item: get(g:, "hackline_highlight_items", "Normal"),
				\ dir: get(g:, "hackline_highlight_secondary", "Comment"),
				\ tail: get(g:, "hackline_highlight_items", "Normal"),
				\ branch: get(g:, "hackline_hightlight_branch", "String"),
				\ end: get(g:, "hackline_highlight_end", "StatusLine"),
				\ active_sm: get(g:, "hackline_highlight_normal", "StatusLine"),
				\ inactive: get(g:, "hackline_highlight_inactive", "StatusLineNC"),
				\ }

	return hackline#util#getStatuslineHighlights( l:highlight_groups )
endfunction

function hackline#modified() abort
	return get(g:, "hackline_modified", "1")
endfunction

function hackline#signature() abort
	let l:fallback_sign = "Vim"

	return &modified && hackline#modified() == "2"
				\ ? get(g:, "hackline_label_modified", "«+»")
				\ : get(g:, "hackline_sign", l:fallback_sign)
endfunction

function hackline#mode_labels() abort
	return #{
				\ n: hackline#signature(),
				\ c: get(g:, "hackline_label_command", "«C»"),
				\ i: get(g:, "hackline_label_insert", "«I»"),
				\ t: get(g:, "hackline_label_terminal", "«T»"),
				\ v: get(g:, "hackline_label_visual", "«V»"),
				\ vb: get(g:, "hackline_label_visual", "«V»"),
				\ s: get(g:, "hackline_label_select", "«S»"),
				\ r: get(g:, "hackline_label_replace", "«R»"),
				\ }
endfunction

function hackline#separators() abort
	return get(g:, "hackline_separators", #{ l: '›', r: '‹' })
endfunction

function hackline#custom_end() abort
	if get(g:, "hackline_fileformat", "0") == 1
		echom "Deprecated `g:hackline_fileformat`! Add `%( %{&fileformat} %)` to `g:hackline_custom_end`."
	endif

	return get(g:, "hackline_custom_end", "
				\%( %{&fileformat} %)
				\ %P/L%L c%c
				\ ")
endfunction

" if hackline#format()
" 	...
" endif
" if hackline#tab_info()
" 	...
" endif

function hackline#mode() abort
	return get(g:, "hackline_mode", "1")
endfunction

function hackline#filetype() abort
	return get(g:, "hackline_filetype", "1")
endfunction

function hackline#bufnr() abort
	if get(g:, "hackline_bufnum", "0")
		echom "Deprecated `g:hackline_bufnum`! Use `g:hackline_bufnr` for hackline.vim number of buffer."
	endif

	return get(g:, "hackline_bufnr", "0")
endfunction

function hackline#ale() abort
	return get(g:, "hackline_ale", "0") && get(b:, "hackline_get_ale", "0")
endfunction

function hackline#nvim_lsp() abort
	return get(g:, "hackline_nvim_lsp", "1") && has("nvim")
endfunction

function hackline#vim_lsp() abort
	return get(g:, "hackline_vim_lsp", "1") && get(b:, "hackline_get_vim_lsp", "0")
endfunction

function hackline#git() abort
	return get(g:, "hackline_git", "1")
endfunction

function hackline#branch_sign() abort
	return get(g:, "hackline_branch_sign", "*")
endfunction

function hackline#git_signs() abort
	return get(g:, "hackline_git_signs", #{
				\added: "+",
				\removed: "-",
				\changed: "~",
				\})
endfunction

function hackline#encoding() abort
	return get(g:, "hackline_encoding", "1")
endfunction

function hackline#laststatus() abort
	return get(g:, 'hackline_laststatus', '2')
endfunction

function hackline#breakpoints() abort
	return #{ md: 70, lg: 90, xl: 130 }
endfunction

function hackline#statusline() abort
	return hackline#ui#statusline#val('active')
endfunction

function hackline#statusline_nc() abort
	return hackline#ui#statusline#val()
endfunction
