" sep.r
function! hackline#ui#nvim_lsp#info(sep_l = "", sep_r = "", breakpoint = "xl") abort
	let l:statusline = ''

	if hackline#util#has_winwidth(a:breakpoint)
		let l:statusline .= '%(' . a:sep_l . 'LSP %{hackline#lsp#names_connected()}' . a:sep_r . '%)'
	else
		let l:statusline .= '%(' . a:sep_l . 'LSP %{hackline#lsp#length_connected()}' . a:sep_r . '%)'
	endif

	return l:statusline
endfunction
