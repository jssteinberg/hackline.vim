function hackline#ale#status() abort
    let l:ale_linters=0
    let l:statusline=''

    try " destructure g:ale_buffer_info
        let l:ale_linters=reduce(get(get(g:ale_buffer_info, buffer_number()), 'loclist'), { acc, val -> acc + 1 }, 0)
    catch | endtry

    " ALE active linter/LSP
    if l:ale_linters > 0
        let l:statusline.='ALE('.string(l:ale_linters).')'
    elseif exists('b:hackline_get_ale') && b:hackline_get_ale == 1
        let l:statusline.='ALE'
    endif

    return l:statusline
endfunction
