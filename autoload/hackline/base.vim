function! hackline#base#filepath(width = 100) abort
    let l:path = expand('%:p:.:h')
    if winwidth(0) <= a:width
        let l:path = pathshorten(l:path)
    endif
    if l:path !=# '.' && l:path !=# ''
        return l:path == '/' ? l:path : l:path.'/'
    endif
    return ''
endfunction

function! hackline#base#fileencoding() abort
    if &fileencoding !=# ''
        return &fileencoding
    else
        return &encoding
    endif
endfunction

function! hackline#base#wordcount() abort
    let currentmode = mode()
    if !exists('g:lastmode_wc')
        let g:lastmode_wc = currentmode
    endif
    if &modified || !exists('b:wordcount') || currentmode =~? '\c.*v' || currentmode != g:lastmode_wc
        let g:lastmode_wc = currentmode
        let l:old_position = getpos('.')
        let l:old_status = v:statusmsg
        execute "silent normal g\<c-g>"
        if v:statusmsg ==# '--No lines in buffer--'
            let b:wordcount = 0
        else
            let l:split_wc = split(v:statusmsg)
            if index(l:split_wc, 'Selected') < 0
                let b:wordcount = str2nr(l:split_wc[11])
            else
                let b:wordcount = str2nr(l:split_wc[5])
            endif
            let v:statusmsg = l:old_status
        endif
        call setpos('.', l:old_position)
        return b:wordcount
    else
        return b:wordcount
    endif
endfunction

function! hackline#base#filesize() abort
    let l:size = getfsize(expand('%'))
    if l:size == 0 || l:size == -1 || l:size == -2
        return ''
    endif
    if l:size < 1024
        return l:size . 'bytes'
    elseif l:size < 1024*1024
        return printf('%.1f', l:size/1024.0) .'k'
    elseif l:size < 1024*1024*1024
        return printf('%.1f', l:size/1024.0/1024.0) .'m'
    else
        return printf('%.1f', l:size/1024.0/1024.0/1024.0) .'g'
    endif
endfunction
