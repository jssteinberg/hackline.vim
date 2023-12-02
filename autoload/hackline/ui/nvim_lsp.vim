let s:servers_seperator = " "

function! hackline#ui#nvim_lsp#names_connected() abort
	return hackline#lsp#names_connected(s:servers_seperator)
endfunction

" seperator left side, LSP label, seperator between label and servers, seperator between, seperator right side, breakpoint for truncation
function! hackline#ui#nvim_lsp#info(append_left = " ", label = "LSP", prepend_label = " ", seperator_servers = " ", prepend_right = " ", truncation_breakpoint = "xl") abort
	let l:statusline = ''
	let s:servers_seperator = a:seperator_servers

	if hackline#util#has_winwidth(a:truncation_breakpoint)
		let l:statusline .= '%(' . a:append_left . a:label . a:prepend_label . '%{%hackline#ui#nvim_lsp#names_connected()%}' . a:prepend_right . '%)'
	else
		let l:statusline .= '%(' . a:append_left . a:label . a:prepend_label . '%{hackline#lsp#length_connected()}' . a:prepend_right . '%)'
	endif

	return l:statusline
endfunction
