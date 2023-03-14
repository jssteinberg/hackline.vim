function! hackline#config#highlight_groups() abort
	let l:highlight_groups = #{
				\ start: get(g:, "hackline_highlight_normal", "StatusLine"),
				\ inactive: get(g:, "hackline_highlight_inactive", "StatusLineNC"),
				\ }

	return hackline#util#getStatuslineHighlights( l:highlight_groups )
endfunction

function! hackline#config#separators() abort
	let l:sep = get(g:, "hackline_separators", #{
				\l: '  /  ',
				\r: '  /  ',
				\})

	return #{
				\l: l:sep.l,
				\r: l:sep.r,
				\}
endfunction

function! hackline#config#mode() abort
	return get(g:, "hackline_mode", "1")
endfunction

function! hackline#config#git_signs() abort
	return get(g:, "hackline_git_signs", #{
				\added: "+",
				\removed: "-",
				\changed: "~",
				\})
endfunction

function! hackline#config#breakpoints() abort
	return #{ md: 70, lg: 90, xl: 130 }
endfunction
