function! hackline#statusline#val (status = 'inactive')
    let s:active = a:status == 'active'
    let s:md = 60
    let s:lg = 100
    let s:xl = 120
    let l:statusline=''

    " Create statusline
    " -----------------

    " Left side

    let l:statusline.= s:active ? '%#IncSearch#' : '%#StatusLineNC#'
    if !s:active | let l:statusline .= "      " | endif
    " Normal mode
    let l:statusline .= s:active && mode() == "n" ? (has('nvim') ? "  Neo " : "  Vim ") : ""
    if s:active && g:hackline_mode
        " Command mode
        let l:statusline .= mode() == "c" ? "%#Cursor# --C--" : ""
        " Insert mode
        let l:statusline .= mode() == "i" ? "%#Todo# --I--" : ""
        " Terminal mode
        let l:statusline .= mode() == "t" ? "%#Todo# --T--" : ""
        " Visual mode
        let l:statusline .= mode() == "v" ? "%#PmenuSel# --V--" : ""
        let l:statusline .= mode() == "\<c-v>" ? "%#PmenuSel# --B--" : ""
        " Replace mode
        let l:statusline .= mode() == "r" ? "%#DiffDelete# --R--" : ""
        " Select mode
        let l:statusline .= mode() == "s" ? "%#DiffDelete# --S--" : ""
    endif
    if g:hackline_bufnum
        if s:active && mode() == "n"
            let l:statusline.='%(:%#IncSearch# %{hackline#base#bufnumber()} %)'
        elseif s:active
            let l:statusline.='%( %#StatusLine# %{hackline#base#bufnumber()} %)'
        else
            let l:statusline.='%(  %{hackline#base#bufnumber()} %)'
        endif
    endif
    let l:statusline.= s:active ? ' %#StatusLine# ' : '%#StatusLineNC#::'
    if g:hackline_filetype
        let l:statusline.='%( %{&filetype} %)'
    endif
    if winwidth(0) > s:md
        let l:statusline.=g:hackline_ale ? '%( %{hackline#ale#status()} %)' : ''
        let l:statusline.=g:hackline_nvim_lsp ? '%( %{hackline#lsp#status()} %)' : ''
    endif
    if winwidth(0) > s:md
        let l:statusline.=s:active ? ' %#Comment# ' : '<<%#StatusLineNC#'
    else
        let l:statusline.=s:active ? ' %#StatusLine# ' : '<<%#StatusLineNC#'
    endif
    if s:active
        let l:statusline.='%<%( %{hackline#base#filepath('.s:lg.')}%#Title#%t %)%([%M] %)'
    else
        let l:statusline.='%<%( %{hackline#base#filepath('.s:lg.')}%t %)%([%M] %)'
    endif
    let l:statusline.='%='

    " Right side

    if winwidth(0) > s:md
        if g:hackline_git && s:active
            let l:statusline.='%( %#Constant#%{hackline#git#branch()} %)'
        endif
        let l:statusline.= s:active ? ' %#StatusLine# ' : ' %#StatusLineNC# '
    endif
    if winwidth(0) > s:xl
        if g:hackline_fileformat
            let l:statusline.='%( %{&fileformat} %)'
        endif
        if g:hackline_encoding
            let l:statusline.='%( %{hackline#base#fileencoding()} %)'
        endif
        if g:hackline_filesize
            let l:statusline.='%( %{hackline#base#filesize()} %)'
        endif
        if g:hackline_wordcount
            let l:statusline.='%( %{hackline#base#wordcount()} words )'
        endif
    endif
    if winwidth(0) > s:md
        if g:hackline_custom_end != ''
            let l:statusline.='%{%g:hackline_custom_end%}'
        endif
    endif

    let l:statusline .= ' '

    return l:statusline
endfunction
