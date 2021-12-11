function! hackline#git#branch() abort
    let l:branch = ''

    if exists('b:gitsigns_head')
        let l:branch = get(b:,'gitsigns_head','')
    elseif exists('*gitbranch#name')
        let l:branch = gitbranch#name()
    elseif exists('g:loaded_fugitive')
        let l:branch = fugitive#head()
    endif

    " TODO: Fix spacing if empty
    "if exists('b:gitsigns_status')
    "    let l:branch .= ' '.get(b:,'gitsigns_status','')
    "endif

    return l:branch !=# '' ? '* ' . branch : ''
endfunction
