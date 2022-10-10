" l:len_i
function hackline#ui#mode#info(...) abort
	if mode() == "i"
		return "%#" . get(g:, "hackline_highlight_insert",   "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_insert", "—I—")
	elseif mode() == "c"
		return "%#" . get(g:, "hackline_highlight_command",   "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_command", "—C—")
	elseif mode() == "t"
		return "%#" . get(g:, "hackline_highlight_terminal", "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_terminal", "—T—")
	elseif mode() == "r"
		return "%#" . get(g:, "hackline_highlight_replace", "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_replace", "—R—")
	elseif mode() == "s"
		return "%#" . get(g:, "hackline_highlight_select", "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_select", "—S—")
	else
		return "%#" . get(g:, "hackline_highlight_visual",   "IncSearch") . "#" . a:1 .. get(g:, "hackline_label_visual", "—V—")
	endif
endfunction
