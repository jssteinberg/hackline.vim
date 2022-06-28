" Basic content for statusline

function hackline#base#tab_info(truncate = 0) abort
	let l:info = !a:truncate ? 'tabs' : 'tabs'

	if &expandtab
		let l:info = !a:truncate ? 'expandtab(sw=' : 'et(sw='
		let l:info .= shiftwidth() . ')'
	elseif shiftwidth() > 0 && shiftwidth() != &tabstop
		" Tabs but differing tabstop and shiftwidth vals = strangenest
		let l:info = 'ts='
		let l:info .= &tabstop
		let l:info .= '(sw=' . shiftwidth() . ')'
	elseif &tabstop > 0
		let l:info = !a:truncate ? 'tabstop=' : 'ts='
		let l:info .= &tabstop
	endif

	return l:info
endfunction

function hackline#base#filepath(width = 100) abort
	let l:path = expand('%:p:.:h')

	if winwidth(0) <= a:width
		let l:path = pathshorten(l:path)
	endif

	if l:path !=# '.' && l:path !=# ''
		return l:path == '/' ? l:path : l:path.'/'
	endif

	return ''
endfunction

function hackline#base#fileencoding() abort
	if &fileencoding !=# ''
		return &fileencoding
	endif

	return &encoding
endfunction

function hackline#base#wordcount() abort
	return wordcount().words
endfunction

function hackline#base#filesize() abort
	let l:size = getfsize(expand('%'))
	if l:size == 0 || l:size == -1 || l:size == -2
		return ''
	endif
	if l:size < 1024
		return l:size . 'B'
	elseif l:size < 1024*1024
		return printf('%.1f', l:size/1024.0) .'kB'
	elseif l:size < 1024*1024*1024
		return printf('%.1f', l:size/1024.0/1024.0) .'MB'
	else
		return printf('%.1f', l:size/1024.0/1024.0/1024.0) .'GB'
	endif
endfunction
