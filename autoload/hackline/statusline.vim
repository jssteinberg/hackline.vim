function! hackline#statusline#val (status = 'inactive')
    let s:active = a:status == 'active'
    let s:w = #{ md: 60, lg: 100, xl: 120 }
    let s:sep = #{ l: '›', r: '‹' }
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
                \ end: 'StatusLine',
                \ active_sm: 'StatusLine',
                \ inactive: 'StatusLineNC' }
    let s:hi = hackline#utils#getStsHis(s:highlight_groups)

    let l:statusline=''

    " Statusline Left Side
    " --------------------

    let l:statusline .= s:active ? winwidth(0) > s:w.md ? s:hi.start : s:hi.active_sm : s:hi.inactive

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
        let l:statusline .= '     <'
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
        let l:statusline .= s:active ? '%( b%{hackline#base#bufnumber()} '.s:sep.l.'%)' : '%(  %{hackline#base#bufnumber()}  %)'
    elseif g:hackline_bufnum
        let l:statusline .= s:active ? '%(b%{hackline#base#bufnumber()}   %)' : '%(  %{hackline#base#bufnumber()}  %)'
    endif

    if s:active && winwidth(0) > s:w.md
        let l:statusline .= '%(%<%)%( '.s:hi.dir.'%{hackline#base#filepath('.s:w.lg.')}'.s:hi.tail.'%t%)%( %M% %)'.s:hi.middle_start
    else
        let l:statusline .= '%(%<%)%( %{hackline#base#filepath('.s:w.lg.')}%t%)%( %M% %)'
    endif

    let l:statusline .= '%='

    " Statusline Right Side
    " ---------------------

    if s:active && winwidth(0) > s:w.md
        let l:statusline .= s:hi.middle_end
        let l:statusline .= g:hackline_ale ? '%('.s:sep.r.' %{hackline#ale#status()} %)' : ''
        let l:statusline .= g:hackline_nvim_lsp ? '%('.s:sep.r.' %{hackline#lsp#status()} %)' : ''
    endif

    if g:hackline_git && s:active && winwidth(0) > s:w.md
        let l:statusline .= '%('.s:sep.r.' %{hackline#git#branch()} %)'
    endif

    let l:statusline .= winwidth(0) > s:w.md && s:active ? ' '.s:hi.end.' ' : '  '

    if winwidth(0) > s:w.xl
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
