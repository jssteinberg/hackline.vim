function hackline#fileencoding#info() abort
	if &fileencoding !=# ''
		return &fileencoding
	endif

	return &encoding
endfunction
