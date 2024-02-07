" nvim lsp

function! hackline#lsp#length_connected() abort
	let l:res = 0

	try
		let l:res = luaeval("require('hackline.lsp').length_connected()")
	catch | endtry

	return l:res != 0 ? l:res : ''
endfunction

function! hackline#lsp#names_connected(sep_i = " ") abort
	let l:res = ''

	try
		let l:res = luaeval("require('hackline.lsp').names_connected(_A[1])", [a:sep_i])
	catch | endtry

	return l:res != '' ? l:res : ''
endfunction
