function hackline#config#highlight_groups() abort
	let l:highlight_groups = #{
				\ start: get(g:, "hackline_highlight_normal", "StatusLine"),
				\ inactive: get(g:, "hackline_highlight_inactive", "StatusLineNC"),
				\ }

	return hackline#util#getStatuslineHighlights( l:highlight_groups )
endfunction

function hackline#config#cwd() abort
	if (get(g:, "hackline_cwd", v:false))
		return "%{split(getcwd(), '/')[-1]}"
	endif

	return ""
endfunction

function hackline#config#separators() abort
	return get(g:, "hackline_separators", #{ l: ' / ', r: ' / ' })
endfunction

function hackline#config#right() abort
	return get(g:, "hackline_right", "Ln %l/%L Col %c")
endfunction

function hackline#config#mode() abort
	return get(g:, "hackline_mode", "1")
endfunction

function hackline#config#nvim_lsp() abort
	return get(g:, "hackline_nvim_lsp", "1") && has("nvim")
endfunction

function hackline#config#vim_lsp() abort
	return get(g:, "hackline_vim_lsp", "1") && get(b:, "hackline_get_vim_lsp", "0")
endfunction

function hackline#config#git_info() abort
	return get(g:, "hackline_git_info", "")
endfunction

function hackline#config#branch_sign() abort
	return get(g:, "hackline_branch_sign", "*")
endfunction

function hackline#config#git_signs() abort
	return get(g:, "hackline_git_signs", #{
				\added: "+",
				\removed: "-",
				\changed: "~",
				\})
endfunction

function hackline#config#laststatus() abort
	return get(g:, 'hackline_laststatus', '2')
endfunction

function hackline#config#breakpoints() abort
	return #{ md: 70, lg: 90, xl: 130 }
endfunction
