" active, sep, hi
function hackline#ui#nvim_lsp#info(...) abort
	let l:statusline = ''

	if a:1 && hackline#util#has_winwidth("xl")
		let l:statusline .= '%(' . a:2.r . ' ' . a:3.mid_item . '%{hackline#lsp#names_connected()}' . '/' . '%{hackline#lsp#length_connected()}' . a:3.mid . '(' . a:3.mid_item . 'LSP' . a:3.mid . ') %)'
	elseif a:1 && hackline#nvim_lsp() && hackline#util#has_winwidth("md")
		let l:statusline .= '%(' . a:2.r . ' ' . a:3.mid_item . '%{hackline#lsp#length_connected()}' . a:3.mid . '(' . a:3.mid_item . 'LSP' . a:3.mid . ') %)'
	elseif a:1 && hackline#nvim_lsp()
		let l:statusline .= '%(' . a:2.r . ' %{hackline#lsp#length_connected()}(LSP) %)'
	endif

	return l:statusline
endfunction

