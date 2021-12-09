function! hackline#git#branch() abort
    let l:branch = ''
    if exists('*gitbranch#name')
        let l:branch = gitbranch#name()
    elseif exists('g:loaded_fugitive')
        let l:branch = fugitive#head()
    endif
    return l:branch !=# '' ? '* ' . branch : ''
endfunction
