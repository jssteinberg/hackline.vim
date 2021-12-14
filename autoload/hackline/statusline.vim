function! hackline#statusline#val (status = 'inactive')
	let s:active = a:status == 'active'
	let s:w = #{ md: 60, lg: 100, xl: 120 }
	let s:sep = #{ l: '›', r: '‹' }
	let s:labels = #{
				\ n: has('nvim') ? 'Neo' : 'Vim',
				\ c: '«C»',
				\ i: '«I»',
				\ t: '«T»',
				\ v: '«V»',
				\ s: '«S»',
				\ r: '«R»',
				\ inactive: '   ',
				\ }
	let s:highlight_groups = #{
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
				\ }
	let s:hi = hackline#utils#getStsHis(s:highlight_groups)

	let l:statusline=''

	" Statusline Left Side
	" --------------------

	let l:statusline .= s:active ? winwidth(0) > s:w.md ? s:hi.start : s:hi.active_sm : s:hi.inactive

	" Modes
	if s:active && g:hackline_mode && mode() != 'n'
		" Command mode
		let l:statusline .= mode() == 'c' ?        s:hi.modes.c.'  '.s:labels.c.' ' : ''
		" Insert mode
		let l:statusline .= mode() == 'i' ?        s:hi.modes.i.'  '.s:labels.i.' ' : ''
		" Terminal mode
		let l:statusline .= mode() == 't' ?        s:hi.modes.t.'  '.s:labels.t.' ' : ''
		" Visual mode
		let l:statusline .= mode() == 'v' ?        s:hi.modes.v.'  '.s:labels.v.' ' : ''
		let l:statusline .= mode() == '\<c-v>' ?  s:hi.modes.vb.'  '.s:labels.v.' ' : ''
		" Replace mode
		let l:statusline .= mode() == 'r' ?        s:hi.modes.r.'  '.s:labels.r.' ' : ''
		" Select mode
		let l:statusline .= mode() == 's' ?        s:hi.modes.s.'  '.s:labels.s.' ' : ''
	elseif s:active
		let l:statusline .= !g:hackline_mode || mode() == 'n' ? '  '.s:labels.n.' ' : ''
	else
		let l:statusline .= '  '.s:labels.inactive.'<'
	endif

	" Filetype (has ties with mode)
	if g:hackline_filetype
		if s:active
			let l:statusline .= '%('.s:sep.l.' %{&filetype} %)'
		else
			let l:statusline .= '%(  %{&filetype} %)'
		endif
	endif

	if winwidth(0) > s:w.md
		let l:statusline .= s:active ? ' '.s:hi.middle_start.' ' : ' >'
	else
		let l:statusline .= s:active ? '  ' : ' >'
	endif

	" Buffer number
	if g:hackline_bufnum && winwidth(0) > s:w.md
		let l:statusline .= s:active ? '%( b%{bufnr()} '.s:sep.l.'%)' : '%(  %{bufnr()}  %)'
	elseif g:hackline_bufnum
		let l:statusline .= s:active ? '%(b%{bufnr()}   %)' : '%(  %{bufnr()}  %)'
	endif

	if s:active && winwidth(0) > s:w.md
		let l:statusline .= '%(%<%)%( '.s:hi.dir.'%{hackline#base#filepath('.s:w.lg.')}'.s:hi.tail.'%t%)%( %M %)'.s:hi.middle_start
	else
		let l:statusline .= '%(%<%)%( %{hackline#base#filepath('.s:w.lg.')}%t%)%( %M %)'
	endif

	let l:statusline .= '%='

	" Statusline Right Side
	" ---------------------

	if s:active && winwidth(0) > s:w.md
		let l:statusline .= s:hi.middle_end
		let l:statusline .= g:hackline_ale ? '%('.s:sep.r.'-'.s:sep.l.' %{hackline#ale#status()} %)' : ''
		let l:statusline .= g:hackline_nvim_lsp ? '%('.s:sep.r.'-'.s:sep.l.' %{hackline#lsp#status()} %)' : ''
	endif

	if g:hackline_git && s:active && winwidth(0) > s:w.md
		let l:statusline .= '%('.s:sep.r.' '.s:hi.git.'%{hackline#git#branch()}'.s:hi.middle_end.' %)'
	endif

	let l:statusline .= winwidth(0) > s:w.md && s:active ? ' '.s:hi.end.' ' : '  '

	if winwidth(0) > s:w.xl
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
	if winwidth(0) > s:w.md
		if g:hackline_custom_end != ''
			let l:statusline .= '%{%g:hackline_custom_end%}'
		endif
	endif

	let l:statusline .= ' '

	return l:statusline
endfunction
