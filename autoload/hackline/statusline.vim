function! hackline#statusline#val (status = 'inactive')
	let l:active = a:status == 'active'
	let l:w = #{ md: 60, lg: 100, xl: 120 }
	let l:sep = #{ l: '›', r: '‹' }
	let l:labels = #{
				\ n: has('nvim') ? 'Neo' : 'Vim',
				\ c: '«C»',
				\ i: '«I»',
				\ t: '«T»',
				\ v: '«V»',
				\ s: '«S»',
				\ r: '«R»',
				\ inactive: '   ',
				\ }
	let l:hi = hackline#utils#getStsHis(#{
				\ start: 'IncSearch',
				\ modes: #{
				\   c: 'Cursor',
				\   i: 'DiffAdd',
				\   t: 'Todo',
				\   v: 'PmenuSel',
				\   vb: 'PmenuSel',
				\   r: 'DiffDelete',
				\   s: 'DiffDelete',
				\ },
				\ middle_start: 'Normal',
				\ dir: 'Comment',
				\ tail: 'Normal',
				\ middle_end: 'Normal',
				\ git: 'Operator',
				\ end: 'StatusLine',
				\ active_sm: 'StatusLine',
				\ inactive: 'StatusLineNC'
				\ })

	let l:statusline=''

	" Statusline Left Side
	" --------------------

	let l:statusline .= l:active ? winwidth(0) > l:w.md ? l:hi.start : l:hi.active_sm : l:hi.inactive

	" Modes
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
		let l:statusline .= '  '.l:labels.inactive.'<'
	endif

	" Filetype (has ties with mode)
	if g:hackline_filetype
		if l:active
			let l:statusline .= '%('.l:sep.l.' %{&filetype} %)'
		else
			let l:statusline .= '%(  %{&filetype} %)'
		endif
	endif

	if winwidth(0) > l:w.md
		let l:statusline .= l:active ? ' '.l:hi.middle_start.' ' : ' >'
	else
		let l:statusline .= l:active ? '  ' : ' >'
	endif

	" Buffer number
	if g:hackline_bufnum && winwidth(0) > l:w.md
		let l:statusline .= l:active ? '%( b%{bufnr()} '.l:sep.l.'%)' : '%(  %{bufnr()}  %)'
	elseif g:hackline_bufnum
		let l:statusline .= l:active ? '%(b%{bufnr()}   %)' : '%(  %{bufnr()}  %)'
	endif

	if l:active && winwidth(0) > l:w.md
		let l:statusline .= '%(%<%)%( '.l:hi.dir.'%{hackline#base#filepath('.l:w.lg.')}'.l:hi.tail.'%t%)%( %M %)'.l:hi.middle_start
	else
		let l:statusline .= '%(%<%)%( %{hackline#base#filepath('.l:w.lg.')}%t%)%( %M %)'
	endif

	let l:statusline .= '%='

	" Statusline Right Side
	" ---------------------

	if l:active && winwidth(0) > l:w.md
		let l:statusline .= l:hi.middle_end
		let l:statusline .= g:hackline_ale ? '%('.l:sep.r.'-'.l:sep.l.' %{hackline#ale#status()} %)' : ''
		let l:statusline .= g:hackline_nvim_lsp ? '%('.l:sep.r.'-'.l:sep.l.' %{hackline#lsp#status()} %)' : ''
	endif

	if g:hackline_git && l:active && winwidth(0) > l:w.md
		let l:statusline .= '%('.l:sep.r.' '.l:hi.git.'%{hackline#git#branch()}'.l:hi.middle_end.' %)'
	endif

	let l:statusline .= winwidth(0) > l:w.md && l:active ? ' '.l:hi.end.' ' : '  '

	if winwidth(0) > l:w.xl
		if g:hackline_encoding
			let l:statusline .= '%( %{hackline#base#fileencoding()} %)'
		endif
		if g:hackline_filesize
			let l:statusline .= '%( %{hackline#base#filesize()} %)'
		endif
		if g:hackline_wordcount
			let l:statusline .= '%( %{hackline#base#wordcount()} words %)'
		endif
	endif
	if winwidth(0) > l:w.md
		if g:hackline_custom_end != ''
			let l:statusline .= '%{%g:hackline_custom_end%}'
		endif
	endif

	let l:statusline .= ' '

	return l:statusline
endfunction
