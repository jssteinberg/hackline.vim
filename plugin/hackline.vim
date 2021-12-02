" ============================================================
" File: hackline.vim
" ============================================================

if exists('g:loaded_hackline')
    finish
endif

let s:save_cpoptions = &cpoptions
"let s:hackline_path_options = [ '%t ', '%{hackline#base#directory()}%t' ]
let s:hackline_path_options = [ '%t ', '%f' ]

" === User configuration variables ===
let g:loaded_hackline = 1
let g:hackline_bufnum = get(g:, 'hackline_bufnum', '1')
let g:hackline_path = get(g:, 'hackline_path', '1')
let g:hackline_mode = get(g:, 'hackline_mode', '1')
let g:hackline_fugitive = get(g:, 'hackline_fugitive', '1')
let g:hackline_fileformat = get(g:, 'hackline_fileformat', '1')
let g:hackline_encoding = get(g:, 'hackline_encoding', '1')
let g:hackline_filetype = get(g:, 'hackline_filetype', '1')
let g:hackline_wordcount = get(g:, 'hackline_wordcount', '0')
let g:hackline_linecount = get(g:, 'hackline_linecount', '0')
let g:hackline_percent = get(g:, 'hackline_percent', '0')
let g:hackline_lineinfo = get(g:, 'hackline_lineinfo', '0')
" ======

set cpoptions&vim
set laststatus=2

if g:hackline_mode
    set noshowmode
endif

function! StatusStart()
    let l:statusline='   '

    " === buffer number ===
    if g:hackline_bufnum
        let l:statusline.=':b'.bufnr().' '
    endif

    return l:statusline
endfunction

function! StatusLinterLsp()
    let l:statusline=''

    if !exists('b:hackline_ale_status')
        let b:hackline_ale_status = ''
    endif

    if exists('g:ale_enabled') && g:ale_enabled
        let l:statusline.=b:hackline_ale_status
    endif

    return l:statusline
endfunction

function! StatusBufMisc()
    let l:statusline=''

    " === File type ===
    if g:hackline_filetype
        let l:statusline.=' '.&filetype.' '
    endif

    " === File format ===
    if g:hackline_fileformat
        let l:statusline.=' '.hackline#base#fileformat().' '
    endif

    " === File encoding ===
    if g:hackline_encoding
        let l:statusline.=' '.hackline#base#fileencoding().' '
    endif

    " === Word count ===
    if g:hackline_wordcount
        let l:statusline.=' '.hackline#base#wordcount().' words '
    endif

    " === Line count ===
    if g:hackline_linecount
        let l:statusline.=' %L lines '
    endif

    return l:statusline
endfunction

function! StatusEnd()
    let l:statusline=' '

    " === Relative line number ===
    if g:hackline_percent
        let l:statusline.=' %3p%%'
    endif

    " === Line:column number ===
    if g:hackline_lineinfo
        let l:statusline.=' %3l:%-3c'
    endif

    let l:statusline.=' %<'

    return l:statusline
endfunction

function! ActiveStatus()
    let l:statusline='%#IncSearch#'
    let l:statusline.='%{StatusStart()}'
    let l:statusline.=' %#StatusLine# '

    " === File path ===
    let l:statusline.=' '.s:hackline_path_options[g:hackline_path].' '

    " === Modified, readonly flag ===
    let l:statusline.='%(%M%R%) '

    "=== Dynamic mode color ===
    if g:hackline_mode
        let l:statusline.='%#Normal#'
        let l:statusline.=     '%{(mode()=="n")?"      ":""}'
        let l:statusline.='%#Comment#'
        let l:statusline.=     '%{(mode()=="c")?" -C-  ":""}'
        let l:statusline.='%#Function#'
        let l:statusline.=     '%{(mode()=="i")?" -I-  ":""}'
        let l:statusline.=     '%{(mode()=="t")?" -T-  ":""}'
        let l:statusline.='%#Statement#'
        let l:statusline.=     '%{(mode()=="v")?" -V-  ":""}'
        let l:statusline.='%{(mode()=="\<c-v>")?" -B-  ":""}'
        let l:statusline.='%#Identifier#'
        let l:statusline.=     '%{(mode()=="r")?" -R-  ":""}'
        let l:statusline.=     '%{(mode()=="s")?" -S-  ":""}'
    endif

    let l:statusline.='%#Normal# '

    " === Divider ===
    let l:statusline.='%='

    " === Git branch ===
    if g:hackline_fugitive
        let l:statusline.='%#Directory#'
        let l:statusline.='%( %{hackline#fugitive#branch()} %)'
    endif

    "let l:statusline.='%#Comment#'
    "let l:statusline.=' %{%StatusLinterLsp()%}'

    let l:statusline.=' %#Normal#%#CursorLine# '
    let l:statusline.='%{%StatusLinterLsp()%}'
    let l:statusline.='%{%StatusBufMisc()%} '

    if g:hackline_percent || g:hackline_lineinfo
        let l:statusline.='%#StatusLine#'
        let l:statusline.='%{%StatusEnd()%}'
    endif

    return l:statusline
endfunction

function! InactiveStatus()
    let l:statusline='%#StatusLineNC#'
    let l:statusline.='%{StatusStart()}  '

    " === File path ===
    let l:statusline.=' '.s:hackline_path_options[g:hackline_path].' '

    " === Modified, readonly flag ===
    let l:statusline.='%(%M%R%) '

    let l:statusline.='%#Comment#%= '
    let l:statusline.='%{%StatusBufMisc()%} '

    if g:hackline_percent || g:hackline_lineinfo
        let l:statusline.='%#StatusLineNC#'
        let l:statusline.='%{%StatusEnd()%}'
    endif

    return l:statusline
endfunction

augroup hackline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveStatus()
    autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveStatus()
    autocmd User ALEJobStarted let b:hackline_ale_status=' ALE  '
augroup END

set statusline=%!ActiveStatus()

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
