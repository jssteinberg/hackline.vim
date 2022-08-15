function hackline#ui#statusline#set (status = v:false) abort
	let l:w = hackline#breakpoints()
	let l:active = a:status
	let l:labels = hackline#mode_labels()
	let l:hi = hackline#highlight_groups()
	let l:sep = hackline#separators()

	let l:statusline=''

	" Statusline Left Side
	" --------------------

	" Set initial highlight group (color)
	let l:statusline .= l:active ? hackline#util#has_winwidth("md") ? l:hi.start : l:hi.active_sm : l:hi.inactive

	" Logic for modes
	if !l:active
		" A certain number of spaces here so content is equally placed on active and inactive
		" statusline to avoid that main statusline content jumps around.
		let l:statusline .= repeat(" ", strlen(hackline#signature())) . '   '
	elseif l:active && hackline#mode() && mode() != 'n'
		let l:statusline .= hackline#ui#mode#info(l:hi.modes, l:labels)
	elseif (!hackline#mode() || mode() == 'n') && hackline#modified() == "2" && &modified
		let l:statusline .= l:active ? l:hi.mod : ''
		let l:statusline .= '  '.l:labels.n.' '
	elseif !hackline#mode() || mode() == 'n'
		let l:statusline .= '  '.l:labels.n.' '
	else
		let l:statusline .= ''
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
	if hackline#util#has_winwidth("md") && l:active
		let l:statusline .= ' ' . l:hi.mid . ' '
	elseif hackline#modified() == "1"
		let l:statusline .= l:sep.l .. l:sep.l
	else
		let l:statusline .= '  '
	endif
	if hackline#modified() == "2" && !hackline#bufnr()
		let l:statusline .= ' '
	endif

	" Show buffer number dependent on state/width
	if hackline#bufnr() && hackline#util#has_winwidth("md")
		let l:statusline .= l:active ? '%( :b' . l:hi.mid_item . '%{bufnr()}' . l:hi.mid . ' ' . l:sep.l . '%)' : '%(   %{bufnr()}  %)'
	elseif hackline#bufnr()
		let l:statusline .= l:active ? '%( :b%{bufnr()}  %)' : '%(  b%{bufnr()}  %)'
	endif

	" Modified flag
	if l:active && hackline#util#has_winwidth("md") && hackline#modified() == "1"
		let l:statusline .= '%( ['.l:hi.mod.'%M'.l:hi.mid.']%) '
	elseif hackline#modified() == "1"
		let l:statusline .= '%(  %M %) '
	elseif hackline#modified() == "2" && hackline#bufnr()
		let l:statusline .= ' '
	endif

	" Show filepath, active and bigger screen gets highlight groups
	if l:active && hackline#util#has_winwidth("lg")
		let l:statusline .= '%(%<%)%('.l:hi.dir.'%{hackline#base#directories('.l:w.lg.')}'.l:hi.tail.'%t %)'.l:hi.mid
	elseif l:active && hackline#util#has_winwidth("md")
		let l:statusline .= '%('.l:hi.tail.'%t %)%(%<%)'.l:hi.mid
	else
		let l:statusline .= '%(%t %)%(%<%) '
	endif

	" Statusline Right Side
	" ---------------------
	let l:statusline .= ' %='

	if l:active && hackline#util#has_winwidth("md")
		let l:statusline .= l:hi.mid
	endif

	" Ale
	if l:active && hackline#util#has_winwidth("md") && hackline#ale()
		let l:statusline .=  '%('.l:sep.r.' '.l:hi.mid_item.'%{hackline#ale#status()}'.l:hi.mid.' %)'
	endif
	" Nvim LSP
	if hackline#nvim_lsp()
		let l:statusline .= hackline#ui#nvim_lsp#info(l:active, l:sep, l:hi)
	endif
	" Vim LSP
	if l:active && hackline#vim_lsp() && hackline#util#has_winwidth("md")
		let l:statusline .= l:sep.r . ' ' . l:hi.mid_item . 'LSP' . l:hi.mid . ' '
	elseif l:active && hackline#vim_lsp()
		let l:statusline .= l:sep.r.' LSP '
	endif

	" Git info
	if hackline#git()
		let l:statusline .= hackline#ui#git#info(l:active, l:sep, l:hi)
	endif

	" Change highlight group if active and bigger screen
	let l:statusline .= hackline#util#has_winwidth("md") && l:active ? ' '.l:hi.end.' ' : '  '

	" Show end custom content
	if hackline#custom_end() != ''
		let l:statusline .= '%{%hackline#custom_end()%}'
	endif

	" Spacing
	let l:statusline .= ' '

	return l:statusline
endfunction
