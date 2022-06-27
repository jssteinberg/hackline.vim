let s:w = #{ md: 60, lg: 90, xl: 120 }

function hackline#statusline#val (status = 'inactive') abort
	let l:active = a:status == 'active'
	let l:labels = #{
				\ n: hackline#signature(),
				\ c: '«C»',
				\ i: '«I»',
				\ t: '«T»',
				\ v: '«V»',
				\ vb: '«V»',
				\ s: '«S»',
				\ r: '«R»',
				\ }
	let l:hi = hackline#highlight_groups()
	let l:sep = hackline#separators()

	let l:statusline=''

	" Statusline Left Side
	" --------------------

	" Set initial highlight group (color)
	let l:statusline .= l:active ? s:has_winwidth("md") ? l:hi.start : l:hi.active_sm : l:hi.inactive

	" Logic for modes
	if l:active && hackline#mode() && mode() != 'n'
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
		let l:statusline .= !hackline#mode() || mode() == 'n' ? '  '.l:labels.n.' ' : ''
	else
		" A certain number of spaces here so content is equally placed on active and inactive
		" statusline to avoid that main statusline content jumps around.
		let l:statusline .= '     '.l:sep.r
	endif

	" Show filetype
	if hackline#filetype()
		if l:active
			let l:statusline .= '%('.l:sep.l.' %{&filetype} %)'
		else
			let l:statusline .= '%(  %{&filetype} %)'
		endif
	endif

	" Change highlight group or add sign
	if s:has_winwidth("md")
		let l:statusline .= l:active ? ' '.l:hi.mid.' ' : ' '.l:sep.l
	else
		let l:statusline .= l:active ? '  ' : ' '.l:sep.l
	endif

	" Show buffer number dependent on state/width
	if hackline#bufnum() && s:has_winwidth("md")
		let l:statusline .= l:active ? '%( '.l:hi.mid_item.'b%{bufnr()}'.l:hi.mid.' '.l:sep.l.'%)' : '%(  %{bufnr()}  %)'
	elseif hackline#bufnum()
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
		let l:statusline .= hackline#ale() ? '%('.l:sep.r.' '.l:hi.mid_item.'%{hackline#ale#status()}'.l:hi.mid.' %)' : ''
		let l:statusline .= hackline#nvim_lsp() ? '%('.l:sep.r.' '.l:hi.mid_item.'%{hackline#lsp#status()}'.l:hi.mid.' %)' : ''
		let l:statusline .= hackline#vim_lsp() ? l:sep.r.' '.l:hi.mid_item.'LspStatus:on'.l:hi.mid.' ' : ''
	endif

	" Show git info
	if hackline#git() && l:active && s:has_winwidth("md")
		let l:statusline .= '%('.l:sep.r.' '.l:hi.mid_item.'* '.l:hi.git.'%{hackline#git#branch()}'.l:hi.mid.' %)'
	endif

	" Change highlight group if active and bigger screen
	let l:statusline .= s:has_winwidth("md") && l:active ? ' '.l:hi.end.' ' : '  '

	" Show misc. file info
	if s:has_winwidth("xl")
		if hackline#encoding()
			let l:statusline .= '%( %{hackline#base#fileencoding()} %)'
		endif
		if hackline#fileformat()
			let l:statusline .= '%( %{&fileformat} %)'
		endif
	endif

	if hackline#tab_info() && s:has_winwidth("lg")
		let l:statusline .= '%( %{hackline#base#tab_info()} %)'
	elseif hackline#tab_info() && s:has_winwidth("md")
		let l:statusline .= '%( %{hackline#base#tab_info(1)} %)'
	endif

	" Show custom end content
	if s:has_winwidth("lg")
		if hackline#custom_end() != ''
			let l:statusline .= '%{%hackline#custom_end()%}'
		endif
	endif

	" Spacing
	let l:statusline .= ' '

	return l:statusline
endfunction

function s:has_winwidth (w = "") abort
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
