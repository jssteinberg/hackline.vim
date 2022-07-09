function hackline#git#branch() abort

	" gitsigns
	let l:branch = get(b:,'gitsigns_head','')

	if l:branch == '' && exists('*FugitiveHead')
		" fugitive.vim
		let l:branch = FugitiveHead()
	elseif l:branch == '' && exists('*gitbranch#name')
		" vim-branch
		let l:branch = gitbranch#name()
	endif

	" return l:branch !=# '' ? l:branch : ''
	return l:branch
endfunction

function hackline#git#status() abort
	" gitsigns
	let l:status = get(b:,'gitsigns_status','')

	" vgit
	try
		let l:stats = get(b:,'vgit_status')
		let l:status = hackline#git_signs().added .. l:stats.added
					\. '/' . hackline#git_signs().removed .. l:stats.removed
					\. '/' . hackline#git_signs().changed .. l:stats.changed
	catch | endtry

	return l:status != '' ? l:status : ''
endfunction
