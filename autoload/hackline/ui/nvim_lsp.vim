" sep_i, sep
function hackline#ui#nvim_lsp#info(...) abort
	let l:statusline = ''

	if hackline#util#has_winwidth("xl")
		let l:statusline .= '%(LSP %{hackline#lsp#names_connected()}%)'
	else
		let l:statusline .= '%(LSP %{hackline#lsp#length_connected()}%)'
	endif

	return l:statusline
endfunction

