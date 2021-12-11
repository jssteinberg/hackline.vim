function! hackline#statusline#val (status = 'inactive')
    let s:active = a:status == 'active'
    let s:md = 60
    let s:lg = 100
    let s:xl = 120
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
                \ middle_start: 'Comment',
                \ tail: 'Constant',
                \ middle_end: 'Comment',
                \ end: 'StatusLine',
                \ inactive: 'StatusLineNC',
                \ }
    let s:hi = hackline#utils#getStsHis(s:highlight_groups)

    let l:statusline=''

    " Statusline Left Side
    " --------------------

    let l:statusline .= s:active ? s:hi.start : s:hi.inactive

    " Modes
    if s:active && g:hackline_mode && mode() != 'n'
        " Command mode
        let l:statusline .= mode() == 'c' ?       s:hi.modes.c.'  «C» ' : ''
        " Insert mode
        let l:statusline .= mode() == 'i' ?       s:hi.modes.i.'  «I» ' : ''
        " Terminal mode
        let l:statusline .= mode() == 't' ?       s:hi.modes.t.'  «T» ' : ''
        " Visual mode
        let l:statusline .= mode() == 'v' ?       s:hi.modes.v.'  «V» ' : ''
        let l:statusline .= mode() == '\<c-v>' ? s:hi.modes.vb.'  «V» ' : ''
        " Replace mode
        let l:statusline .= mode() == 'r' ?       s:hi.modes.r.'  «R» ' : ''
        " Select mode
        let l:statusline .= mode() == 's' ?       s:hi.modes.s.'  «S» ' : ''
    elseif s:active
        let l:statusline .= !g:hackline_mode || mode() == 'n' ? (has('nvim') ? '  Neo ' : '  Vim ') : ''
    else
        let l:statusline .= '   <  '
    endif

    " Filetype (has ties with mode)
    if g:hackline_filetype
        if g:hackline_mode && s:active && mode() != 'n'
            let l:statusline .= '%( %{&filetype}  %)'
        elseif s:active
            let l:statusline .= '%(‹%{&filetype}› %)'
        else
            let l:statusline .= '%( %{&filetype}  %)'
        endif
    endif

    if winwidth(0) > s:md
        let l:statusline .= s:active ? ' '.s:hi.middle_start.' ' : ' >'
    else
        let l:statusline .= s:active ? '  ' : ' >'
    endif

    " Buffer number
    if g:hackline_bufnum && winwidth(0) > s:md
        let l:statusline .= s:active ? '%( ‹b%{hackline#base#bufnumber()}› %)' : '%(  b%{hackline#base#bufnumber()}  %)'
    elseif g:hackline_bufnum
        let l:statusline .= s:active ? '%(b%{hackline#base#bufnumber()}  %)' : '%( %{hackline#base#bufnumber()}  %)'
    endif

    if s:active && winwidth(0) > s:md
        let l:statusline .= '%(%<%)%( %{hackline#base#filepath('.s:lg.')}'.s:hi.tail.'%t %)%(%M %)'
    else
        let l:statusline .= '%(%<%)%( %{hackline#base#filepath('.s:lg.')}%t %)%(%M %)'
    endif

    if winwidth(0) > s:md
        let l:statusline .= s:active ? s:hi.middle_end : ''

        if s:active
            let l:statusline .= g:hackline_ale ? '%( « %{hackline#ale#status()} %)' : ''
            let l:statusline .= g:hackline_nvim_lsp ? '%( « %{hackline#lsp#status()} %)' : ''
        else
            let l:statusline .= g:hackline_ale ? '%( « %{hackline#ale#status()} %)' : ''
            let l:statusline .= g:hackline_nvim_lsp ? '%( « %{hackline#lsp#status()} %)' : ''
        endif
    endif

    if winwidth(0) > s:md
        if g:hackline_git && s:active
            let l:statusline .= '%( %{hackline#git#branch()} %)'
        endif
    endif

    let l:statusline .= '%='

    if winwidth(0) > s:md
        let l:statusline .= s:active ? ' '.s:hi.end.' ' : '  '
    else
        let l:statusline .= s:active ? '  ' : ' >'
    endif

    " Statusline Right Side
    " ---------------------

    if winwidth(0) > s:xl
        if g:hackline_fileformat
            let l:statusline .= '%( %{&fileformat} %)'
        endif
        if g:hackline_encoding
            let l:statusline .= '%( %{hackline#base#fileencoding()} %)'
        endif
        if g:hackline_filesize
            let l:statusline .= '%( %{hackline#base#filesize()} %)'
        endif
        if g:hackline_wordcount
            let l:statusline .= '%( %{hackline#base#wordcount()} words )'
        endif
    endif
    if winwidth(0) > s:md
        if g:hackline_custom_end != ''
            let l:statusline .= '%{%g:hackline_custom_end%}'
        endif
    endif

    let l:statusline .= ' '

    return l:statusline
endfunction
