" active, hi, sep
function hackline#ui#nvim_lsp#info(...) abort
	let l:statusline = ''

	if a:1 && hackline#util#has_winwidth("xl")
		let l:statusline .= '%( ' . a:3.r . ' LSP %{hackline#lsp#names_connected()} %)'
	elseif a:1 && hackline#nvim_lsp()
		let l:statusline .= '%( ' . a:3.r . ' LSP %{hackline#lsp#length_connected()} %)'
	endif

	return l:statusline
endfunction

