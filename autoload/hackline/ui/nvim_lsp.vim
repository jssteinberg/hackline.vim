" sep.l, sep.r
function! hackline#ui#nvim_lsp#info(...) abort
	let l:statusline = ''

	if hackline#util#has_winwidth("xl")
		let l:statusline .= '%(' . a:1 . 'LSP %{hackline#lsp#names_connected()}' . a:2 . '%)'
	else
		let l:statusline .= '%(' . a:1 . 'LSP %{hackline#lsp#length_connected()}' . a:2 . '%)'
	endif

	return l:statusline
endfunction
