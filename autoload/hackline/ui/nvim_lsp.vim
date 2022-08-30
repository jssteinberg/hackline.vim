" active, hi, sep
function hackline#ui#nvim_lsp#info(...) abort
	let l:statusline = ''

	if a:1 && hackline#util#has_winwidth("xl")
		let l:statusline .= '%(' . a:3.r . ' ' . a:2.mid_item . '%{hackline#lsp#names_connected()}' . '/' . '%{hackline#lsp#length_connected()}' . a:2.mid . '(' . a:2.mid_item . 'LSP' . a:2.mid . ') %)'
	elseif a:1 && hackline#nvim_lsp() && hackline#util#has_winwidth("md")
		let l:statusline .= '%(' . a:3.r . ' ' . a:2.mid_item . '%{hackline#lsp#length_connected()}' . a:2.mid . '(' . a:2.mid_item . 'LSP' . a:2.mid . ') %)'
	elseif a:1 && hackline#nvim_lsp()
		let l:statusline .= '%(' . a:3.r . ' %{hackline#lsp#length_connected()}(LSP) %)'
	endif

	return l:statusline
endfunction

