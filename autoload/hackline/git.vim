function hackline#git#branch() abort
	let l:branch = ''

	" gitsigns
	if exists('b:gitsigns_head')
		let l:branch = get(b:,'gitsigns_head','')
	" fugitive.vim
	elseif exists('*FugitiveHead')
		let l:branch = FugitiveHead()
	" vim-branch
	elseif exists('*gitbranch#name')
		let l:branch = gitbranch#name()
	endif

	return l:branch !=# '' ? l:branch : ''
endfunction

function hackline#git#status() abort
	" gitsigns
	let l:status = get(b:,'gitsigns_status','')

	return l:status != '' ? l:status : ''
endfunction
