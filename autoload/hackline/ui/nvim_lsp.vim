" sep.r
function! hackline#ui#nvim_lsp#info(...) abort
	let l:statusline = ''

	if hackline#util#has_winwidth("xl")
		let l:statusline .= '%(LSP %{hackline#lsp#names_connected()}' . a:1 . '%)'
	else
		let l:statusline .= '%(LSP %{hackline#lsp#length_connected()}' . a:1 . '%)'
	endif

	return l:statusline
endfunction
