function hackline#lsp#length_connected() abort
	if !has('nvim') | return '' | endif

	let l:res = 0

	try
		let l:res = luaeval("require('hackline.lsp').length_connected()")
	catch | endtry

	return l:res != 0 ? l:res : ''
endfunction

function hackline#lsp#names_connected() abort
	if !has('nvim') | return '' | endif

	let l:res = ''

	try
		let l:res = luaeval("require('hackline.lsp').names_connected()")
	catch | endtry

	return l:res != '' ? l:res : ''
endfunction
