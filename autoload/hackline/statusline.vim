function! hackline#statusline#val (status = 'inactive')
	let l:active = a:status == 'active'
	let l:w = #{ md: 60, lg: 90, xl: 120 }
	let l:labels = #{
				\ n: g:hackline_signature != '' ? g:hackline_signature : has('nvim') ? 'Neo' : 'Vim',
				\ c: '«C»',
				\ i: '«I»',
				\ t: '«T»',
				\ v: '«V»',
				\ vb: '«V»',
				\ s: '«S»',
				\ r: '«R»',
				\ }
	let l:hi = hackline#utils#getStsHis(#{
				\ start: 'Cursor',
				\ modes: #{
				\   c: 'Todo',
				\   i: 'DiffAdd',
				\   t: 'Todo',
				\   v: 'PmenuSel',
				\   vb: 'PmenuSel',
				\   r: 'IncSearch',
				\   s: 'IncSearch',
				\ },
				\ mid: 'Comment',
				\ mid_item: 'Normal',
				\ dir: 'Comment',
				\ tail: 'Normal',
				\ git: 'String',
				\ end: 'StatusLine',
				\ active_sm: 'StatusLine',
				\ inactive: 'StatusLineNC'
				\ })
	let l:sep = #{ l: '›', r: '‹' }

	let l:statusline=''

	" Statusline Left Side
	" --------------------

	" Set initial highlight group (color)
	let l:statusline .= l:active ? winwidth(0) > l:w.md ? l:hi.start : l:hi.active_sm : l:hi.inactive

	" Logic for modes
	if l:active && g:hackline_mode && mode() != 'n'
		" Command mode
		let l:statusline .= mode() == 'c' ?        l:hi.modes.c.'  '.l:labels.c.' ' : ''
		" Insert mode
		let l:statusline .= mode() == 'i' ?        l:hi.modes.i.'  '.l:labels.i.' ' : ''
		" Terminal mode
		let l:statusline .= mode() == 't' ?        l:hi.modes.t.'  '.l:labels.t.' ' : ''
		" Visual mode
		let l:statusline .= mode() == 'v' ?        l:hi.modes.v.'  '.l:labels.v.' ' : ''
		let l:statusline .= mode() == '\<c-v>' ?  l:hi.modes.vb.'  '.l:labels.v.' ' : ''
		" Replace mode
		let l:statusline .= mode() == 'r' ?        l:hi.modes.r.'  '.l:labels.r.' ' : ''
		" Select mode
		let l:statusline .= mode() == 's' ?        l:hi.modes.s.'  '.l:labels.s.' ' : ''
	elseif l:active
		let l:statusline .= !g:hackline_mode || mode() == 'n' ? '  '.l:labels.n.' ' : ''
	else
		let l:statusline .= '     <'
	endif

	" Show filetype
	if g:hackline_filetype
		if l:active
			let l:statusline .= '%('.l:sep.l.' %{&filetype} %)'
		else
			let l:statusline .= '%(  %{&filetype} %)'
		endif
	endif

	" Change highlight group or add sign
	if winwidth(0) > l:w.md
		let l:statusline .= l:active ? ' '.l:hi.mid.' ' : ' >'
	else
		let l:statusline .= l:active ? '  ' : ' >'
	endif

	" Show buffer number dependent on state/width
	if g:hackline_bufnum && winwidth(0) > l:w.md
		let l:statusline .= l:active ? '%( '.l:hi.mid_item.'b%{bufnr()}'.l:hi.mid.' '.l:sep.l.'%)' : '%(  %{bufnr()}  %)'
	elseif g:hackline_bufnum
		let l:statusline .= l:active ? '%(b%{bufnr()}   %)' : '%(  %{bufnr()}  %)'
	endif

	" Show filepath, active and bigger screen gets highlight groups
	if l:active && winwidth(0) > l:w.md
		let l:statusline .= '%(%<%)%( '.l:hi.dir.'%{hackline#base#filepath('.l:w.lg.')}'.l:hi.tail.'%t %)%(%M %)'.l:hi.mid
	else
		let l:statusline .= '%(%<%)%( %{hackline#base#filepath('.l:w.lg.')}%t %)%(%M %)'
	endif

	" Statusline Right Side
	" ---------------------
	let l:statusline .= ' %='

	" Show ALE and LSP info
	if l:active && winwidth(0) > l:w.md
		let l:statusline .= l:hi.mid
		let l:statusline .= g:hackline_ale ? '%('.l:sep.r.' '.l:hi.mid_item.'%{hackline#ale#status()}'.l:hi.mid.' %)' : ''
		let l:statusline .= g:hackline_nvim_lsp ? '%('.l:sep.r.' '.l:hi.mid_item.'%{hackline#lsp#status()}'.l:hi.mid.' %)' : ''
	endif

	" Show git info
	if g:hackline_git && l:active && winwidth(0) > l:w.md
		let l:statusline .= '%('.l:sep.r.' '.l:hi.mid_item.'* '.l:hi.git.'%{hackline#git#branch()}'.l:hi.mid.' %)'
	endif

	" Change highlight group if active and bigger screen
	let l:statusline .= winwidth(0) > l:w.md && l:active ? ' '.l:hi.end.' ' : '  '

	" Show misc. file info
	if winwidth(0) > l:w.xl
		if g:hackline_encoding
			let l:statusline .= '%( %{hackline#base#fileencoding()} %)'
		endif
		if g:hackline_fileformat
			let l:statusline .= '%( %{&fileformat} %)'
		endif
	endif

	if g:hackline_tab_info && winwidth(0) > l:w.lg
		let l:statusline .= '%( %{hackline#base#tab_info()} %)'
	elseif g:hackline_tab_info && winwidth(0) > l:w.md
		let l:statusline .= '%( %{hackline#base#tab_info(1)} %)'
	endif

	" Show custom end content
	if winwidth(0) > l:w.lg
		if g:hackline_custom_end != ''
			let l:statusline .= '%{%g:hackline_custom_end%}'
		endif
	endif

	" Spacing
	let l:statusline .= ' '

	return l:statusline
endfunction
