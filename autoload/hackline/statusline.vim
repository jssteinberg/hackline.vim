function! hackline#statusline#val(status = 'inactive') abort
    let l:statusline='%#StatusLineNC#'

    if a:status == 'active'
        let l:statusline='%#StatusLine#'
    endif

    "let l:statusline.='%{hackline#base#bufnumber()}'
    "let l:statusline.='%{hackline#base#filepath()}'
    "let l:statusline.='%{hackline#base#bufflags()}'
    "let l:statusline.='%{hackline#base#mode()}'

    return l:statusline . a:status
endfunction
