let s:w = #{ md: 60, lg: 90, xl: 120 }

function! hackline#statusline#val (status = 'inactive')
	let l:active = a:status == 'active'
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
				\ start: 'StatusLine',
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
	let l:statusline .= l:active ? s:has_winwidth("md") ? l:hi.start : l:hi.active_sm : l:hi.inactive

	" Logic for modes
	if l:active && g:hackline_mode && mode() != 'n'
		if mode() == "i"
			let l:statusline .= l:hi.modes.i.'  '.l:labels.i.' '
		elseif mode() == "c"
			let l:statusline .= l:hi.modes.c.'  '.l:labels.c.' '
		elseif mode() == "t"
			let l:statusline .= l:hi.modes.t.'  '.l:labels.t.' '
		elseif mode() == "r"
			let l:statusline .= l:hi.modes.r.'  '.l:labels.r.' '
		elseif mode() == "s"
			let l:statusline .= l:hi.modes.s.'  '.l:labels.s.' '
		else
			let l:statusline .= l:hi.modes.v.'  '.l:labels.v.' '
		endif
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
			let l:statusline .= '%( ~%{&filetype}~%)'
		endif
	endif

	" Change highlight group or add sign
	if s:has_winwidth("md")
		let l:statusline .= l:active ? ' '.l:hi.mid.' ' : ' >'
	else
		let l:statusline .= l:active ? '  ' : ' >'
	endif

	" Show buffer number dependent on state/width
	if g:hackline_bufnum && s:has_winwidth("md")
		let l:statusline .= l:active ? '%( '.l:hi.mid_item.'b%{bufnr()}'.l:hi.mid.' '.l:sep.l.'%)' : '%(  %{bufnr()}  %)'
	elseif g:hackline_bufnum
		let l:statusline .= l:active ? '%(b%{bufnr()}   %)' : '%(  %{bufnr()}  %)'
	endif

	" Modified flag
	if l:active && s:has_winwidth("md")
		let l:statusline .= '%( '.l:hi.mid_item.'%m'.l:hi.mid.'%) '
	else
		let l:statusline .= '%( %m%) '
	endif

	" Show filepath, active and bigger screen gets highlight groups
	if l:active && s:has_winwidth("md")
		let l:statusline .= '%(%<%)%('.l:hi.dir.'%{hackline#base#filepath('.s:w.lg.')}'.l:hi.tail.'%t %)'.l:hi.mid
	else
		let l:statusline .= '%(%<%)%(%{hackline#base#filepath('.s:w.lg.')}%t %)'
	endif

	" Statusline Right Side
	" ---------------------
	let l:statusline .= ' %='

	" Show LSP info
	if l:active && s:has_winwidth("md")
		let l:statusline .= l:hi.mid
		let l:statusline .= g:hackline_ale ? '%('.l:sep.r.' '.l:hi.mid_item.'%{hackline#ale#status()}'.l:hi.mid.' %)' : ''
		let l:statusline .= g:hackline_nvim_lsp ? '%('.l:sep.r.' '.l:hi.mid_item.'Lsp:%{hackline#lsp#status()}'.l:hi.mid.' %)' : ''
		let l:statusline .= g:hackline_vim_lsp && exists("b:hackline_get_vim_lsp") ? l:sep.r.' '.l:hi.mid_item.'Lsp'.l:hi.mid.' ' : ''
	endif

	" Show git info
	if g:hackline_git && l:active && s:has_winwidth("md")
		let l:statusline .= '%('.l:sep.r.' '.l:hi.mid_item.'* '.l:hi.git.'%{hackline#git#branch()}'.l:hi.mid.' %)'
	endif

	" Change highlight group if active and bigger screen
	let l:statusline .= s:has_winwidth("md") && l:active ? ' '.l:hi.end.' ' : '  '

	" Show misc. file info
	if s:has_winwidth("xl")
		if g:hackline_encoding
			let l:statusline .= '%( %{hackline#base#fileencoding()} %)'
		endif
		if g:hackline_fileformat
			let l:statusline .= '%( %{&fileformat} %)'
		endif
	endif

	if g:hackline_tab_info && s:has_winwidth("lg")
		let l:statusline .= '%( %{hackline#base#tab_info()} %)'
	elseif g:hackline_tab_info && s:has_winwidth("md")
		let l:statusline .= '%( %{hackline#base#tab_info(1)} %)'
	endif

	" Show custom end content
	if s:has_winwidth("lg")
		if g:hackline_custom_end != ''
			let l:statusline .= '%{%g:hackline_custom_end%}'
		endif
	endif

	" Spacing
	let l:statusline .= ' '

	return l:statusline
endfunction

function s:has_winwidth (w = "")
	if &laststatus == 3
		return v:true
	elseif a:w == "md" &&  winwidth(0) > s:w.md
		return v:true
	elseif a:w == "lg" &&  winwidth(0) > s:w.lg
		return v:true
	elseif a:w == "xl" &&  winwidth(0) > s:w.xl
		return v:true
	endif

	return v:false
endfunction
