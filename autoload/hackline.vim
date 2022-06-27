" Default config for hackline.vim
" TODO: Move all default config to this file...

function! hackline#highlight_groups()
	let l:highlight_groups = #{
				\ start: get(g:, "hackline_highlight_normal", "StatusLine"),
				\ modes: #{
				\   c:  get(g:, "hackline_highlight_command",  "Todo"),
				\   i:  get(g:, "hackline_highlight_insert",   "DiffAdd"),
				\   t:  get(g:, "hackline_highlight_terminal", "Todo"),
				\   v:  get(g:, "hackline_highlight_visual",   "PmenuSel"),
				\   vb: get(g:, "hackline_highlight_visual",   "PmenuSel"),
				\   r:  get(g:, "hackline_highlight_replace",  "IncSearch"),
				\   s:  get(g:, "hackline_highlight_select",   "IncSearch"),
				\ },
				\ mid: 'Comment',
				\ mid_item: 'Normal',
				\ dir: 'Comment',
				\ tail: 'Normal',
				\ git: 'String',
				\ end: 'StatusLine',
				\ active_sm: get(g:, "hackline_highlight_normal", "StatusLine"),
				\ inactive: 'StatusLineNC'
				\ }

	return hackline#utils#getStatuslineHighlights( l:highlight_groups )
endfunction
