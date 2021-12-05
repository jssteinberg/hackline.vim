function! hackline#statusline#val(status = 'inactive') abort
    let s:active = a:status == 'active'
    let l:statusline=''

    let l:statusline.= s:active ? '%#IncSearch# ' : '%#StatusLineNC# '
    let l:statusline.='%{hackline#base#bufnumber()}'
    let l:statusline.= s:active ? ' %#StatusLine# ' : ' %#StatusLineNC# '
    let l:statusline.='%{hackline#base#filepath()}'
    "let l:statusline.='%{hackline#base#bufflags()}'
    "let l:statusline.='%{hackline#base#mode()}'

    return l:statusline
endfunction
