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

	return l:branch !=# '' ? branch : ''
endfunction

function hackline#git#status() abort
	if get(b:,'gitsigns_status','') != ''
		return get(b:,'gitsigns_status','')
	endif
endfunction
