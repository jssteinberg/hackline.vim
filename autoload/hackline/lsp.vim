function hackline#lsp#status() abort
	if !has('nvim') | return '' | endif

	let l:lsp_linters=''
	let l:statusline=''

	try " TODO: test vim without lua
		let l:lsp_linters.=luaeval("require('hackline.lsp').named_servers()")
	catch | endtry

	if l:lsp_linters != ''
		let l:statusline.=l:lsp_linters
	endif

	return l:statusline
endfunction
