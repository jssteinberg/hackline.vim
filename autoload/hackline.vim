" Default config for hackline.vim

function hackline#init() abort
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

function hackline#highlight_groups() abort
	let l:highlight_groups = #{
				\ start: get(g:, "hackline_highlight_normal", "StatusLine"),
				\ modes: #{
				\   i:  get(g:, "hackline_highlight_insert",   "IncSearch"),
				\   v:  get(g:, "hackline_highlight_visual",   "IncSearch"),
				\   vb: get(g:, "hackline_highlight_visual",   "IncSearch"),
				\   r:  get(g:, "hackline_highlight_replace",  "IncSearch"),
				\   s:  get(g:, "hackline_highlight_select",   "IncSearch"),
				\   c:  get(g:, "hackline_highlight_command",  "IncSearch"),
				\   t:  get(g:, "hackline_highlight_terminal", "IncSearch"),
				\ },
				\ inactive: get(g:, "hackline_highlight_inactive", "StatusLineNC"),
				\ }

	return hackline#util#getStatuslineHighlights( l:highlight_groups )
endfunction

function hackline#mode_labels() abort
	return #{
				\ c: get(g:, "hackline_label_command", "COMMAND"),
				\ i: get(g:, "hackline_label_insert", "INSERT"),
				\ t: get(g:, "hackline_label_terminal", "TERMINAL"),
				\ v: get(g:, "hackline_label_visual", "VISUAL"),
				\ s: get(g:, "hackline_label_select", "SELECT"),
				\ r: get(g:, "hackline_label_replace", "REPLACE"),
				\ }
endfunction

function hackline#separators() abort
	return get(g:, "hackline_separators", #{ l: ' / ', r: ' / ' })
endfunction

function hackline#right() abort
	return get(g:, "hackline_right", "Ln %l/%L Col %c")
endfunction

function hackline#mode() abort
	return get(g:, "hackline_mode", "1") && !&showmode
endfunction

function hackline#nvim_lsp() abort
	return get(g:, "hackline_nvim_lsp", "1") && has("nvim")
endfunction

function hackline#vim_lsp() abort
	return get(g:, "hackline_vim_lsp", "1") && get(b:, "hackline_get_vim_lsp", "0")
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

function hackline#laststatus() abort
	return get(g:, 'hackline_laststatus', '2')
endfunction

function hackline#breakpoints() abort
	return #{ md: 70, lg: 90, xl: 130 }
endfunction
