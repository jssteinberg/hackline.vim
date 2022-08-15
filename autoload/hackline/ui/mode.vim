" l:hi.modes, l:labels
function hackline#ui#mode#info(...) abort
	if mode() == "i"
		return a:1.i.'  '.a:2.i.' '
	elseif mode() == "c"
		return a:1.c.'  '.a:2.c.' '
	elseif mode() == "t"
		return a:1.t.'  '.a:2.t.' '
	elseif mode() == "r"
		return a:1.r.'  '.a:2.r.' '
	elseif mode() == "s"
		return a:1.s.'  '.a:2.s.' '
	else
		return a:1.v.'  '.a:2.v.' '
	endif
endfunction
