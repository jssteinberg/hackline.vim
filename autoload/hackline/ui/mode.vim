" l:len_i
function hackline#ui#mode#info(...) abort
	if mode() == "i"
		return "%#" . get(g:, "hackline_highlight_insert",   "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_insert", "INSERT")
	elseif mode() == "c"
		return "%#" . get(g:, "hackline_highlight_command",   "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_command", "COMMAND")
	elseif mode() == "t"
		return "%#" . get(g:, "hackline_highlight_terminal", "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_terminal", "TERMINAL")
	elseif mode() == "r"
		return "%#" . get(g:, "hackline_highlight_replace", "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_replace", "REPLACE")
	elseif mode() == "s"
		return "%#" . get(g:, "hackline_highlight_select", "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_select", "SELECT")
	else
		return "%#" . get(g:, "hackline_highlight_visual",   "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_visual", "VISUAL")
	endif
endfunction
