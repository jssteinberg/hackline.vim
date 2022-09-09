" l:hi.modes, l:labels
function hackline#ui#mode#info(...) abort
	if mode() == "i"
		return a:2.i
	elseif mode() == "c"
		return a:2.c
	elseif mode() == "t"
		return a:2.t
	elseif mode() == "r"
		return a:2.r
	elseif mode() == "s"
		return a:2.s
	else
		return a:2.v
	endif
endfunction
