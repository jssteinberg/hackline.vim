function! hackline#statusline#val (status = 'inactive')
    let s:active = a:status == 'active'
    let s:md = 60
    let s:lg = 100
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
        let l:statusline .= mode() == "i" ? "%#DiffAdd# --I--" : ""
        " Terminal mode
        let l:statusline .= mode() == "t" ? "%#DiffAdd# --T--" : ""
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
    let l:statusline.= s:active ? ' %#StatusLine#  ' : '%#StatusLineNC# ::'
    if g:hackline_filetype && &filetype
        let l:statusline.='%(  %{&filetype} %)'
    endif
    if winwidth(0) > s:md
        if g:hackline_ale
            let l:statusline.='%( %{hackline#ale#status()} %)'
        endif
        if g:hackline_nvim_lsp
            let l:statusline.='%( %{hackline#lsp#status()} %)'
        endif
    endif
    if winwidth(0) > s:md
        let l:statusline.= s:active ? ' %#Normal# ' : '::%#StatusLineNC#'
    else
        let l:statusline.= s:active ? ' %#StatusLine# ' : '::%#StatusLineNC#'
    endif
    let l:statusline.='%( %{hackline#base#filepath()} %)%([%M%R] %)'
    let l:statusline.='%='

    " Right side

    if winwidth(0) > s:md
        if g:hackline_fugitive && s:active
            let l:statusline.='%( %#Directory#%{hackline#fugitive#branch()} %)'
        endif
        let l:statusline.= s:active ? ' %#StatusLine# ' : ' %#StatusLineNC# '
    endif
    if winwidth(0) > s:lg
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

    let l:statusline .= ' %<'

    return l:statusline
endfunction
