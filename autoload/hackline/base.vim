" Basic content for statusline

function hackline#base#directories(width = 100) abort
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

function hackline#base#tab_info(...) abort
	echom "Deprecated `hackline#base#tab_info()`! Use `hackline#tab#info()` for hackline.vim tab info."
endfunction
