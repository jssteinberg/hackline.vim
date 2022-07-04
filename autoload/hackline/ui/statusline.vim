function hackline#ui#statusline#val (status = 'inactive') abort
	let l:w = hackline#breakpoints()
	let l:active = a:status == 'active'
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
		let l:statusline .= '      '
	elseif l:active && hackline#mode() && mode() != 'n'

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

	" Show buffer number dependent on state/width
	if hackline#bufnr() && hackline#util#has_winwidth("md")
		let l:statusline .= l:active ? '%( :b'.l:hi.mid_item.'%{bufnr()}'.l:hi.mid.' '.l:sep.l.'%)' : '%(   %{bufnr()}  %)'
	elseif hackline#bufnr()
		let l:statusline .= l:active ? '%(:b%{bufnr()}   %)' : '%(  b%{bufnr()}  %)'
	else
		let l:statusline .= ' '
	endif

	" Modified flag
	if l:active && hackline#util#has_winwidth("md") && hackline#modified() == "1"
		let l:statusline .= '%( ['.l:hi.mid_item.'%M'.l:hi.mid.']%) '
	elseif hackline#modified() == "1"
		let l:statusline .= '%(  %M %) '
	endif

	" Show filepath, active and bigger screen gets highlight groups
	if l:active && hackline#util#has_winwidth("md")
		let l:statusline .= '%(%<%)%('.l:hi.dir.'%{hackline#base#directories('.l:w.lg.')}'.l:hi.tail.'%t %)'.l:hi.mid
	else
		let l:statusline .= '%(%<%)%(%{hackline#base#directories('.l:w.lg.')}%t %)'
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
	if l:active && hackline#nvim_lsp() && hackline#util#has_winwidth("xl")
		let l:statusline .= '%(' . l:sep.r . ' ' . l:hi.mid_item . '%{hackline#lsp#names_connected()}' . l:hi.mid . '(' . l:hi.mid_item . 'LSP' . l:hi.mid . ') %)'
	elseif l:active && hackline#nvim_lsp() && hackline#util#has_winwidth("md")
		let l:statusline .= '%(' . l:sep.r . ' ' . l:hi.mid_item . '%{hackline#lsp#length_connected()}' . l:hi.mid . '(' . l:hi.mid_item . 'LSP' . l:hi.mid . ') %)'
	elseif l:active && hackline#nvim_lsp()
		let l:statusline .= '%(' . l:sep.r . ' %{hackline#lsp#length_connected()}(LSP) %)'
	endif
	" Vim LSP
	if l:active && hackline#vim_lsp() && hackline#util#has_winwidth("md")
		let l:statusline .= l:sep.r . ' ' . l:hi.mid_item . 'LSP' . l:hi.mid . ' '
	elseif l:active && hackline#vim_lsp()
		let l:statusline .= l:sep.r.' LSP '
	endif

	" Git info
	if hackline#git() && l:active && hackline#util#has_winwidth("md")
		let l:statusline .= '%('.l:sep.r.' '.l:hi.mid_item..hackline#branch_sign()..l:hi.branch.'%{hackline#git#branch()}'.l:hi.mid.' %)'
		let l:statusline .= '%('.l:hi.mid_item.'%{hackline#git#status()}'.l:hi.mid.' %)'
	endif

	" Change highlight group if active and bigger screen
	let l:statusline .= hackline#util#has_winwidth("md") && l:active ? ' '.l:hi.end.' ' : '  '

	" Show misc. file info
	if hackline#util#has_winwidth("xl")
		if hackline#encoding()
			let l:statusline .= '%( %{hackline#base#fileencoding()} %)'
		endif
		if hackline#fileformat()
			let l:statusline .= '%( %{&fileformat} %)'
		endif
	endif

	" show custom end content
	if hackline#custom_end() != ''
		let l:statusline .= '%{%hackline#custom_end()%}'
	endif

	" Spacing
	let l:statusline .= ' '

	return l:statusline
endfunction
