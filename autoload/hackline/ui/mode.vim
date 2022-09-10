" l:hi.modes, l:labels, l:len_i
function hackline#ui#mode#info(...) abort
	if mode() == "i"
		return a:1.i .. a:3 .. a:2.i
	elseif mode() == "c"
		return a:1.i .. a:3 .. a:2.c
	elseif mode() == "t"
		return a:1.i .. a:3 .. a:2.t
	elseif mode() == "r"
		return a:1.i .. a:3 .. a:2.r
	elseif mode() == "s"
		return a:1.i .. a:3 .. a:2.s
	else
		return a:1.i .. a:3 .. a:2.v
	endif
endfunction
