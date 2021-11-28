" ============================================================
" File: skyline.vim
" ============================================================

if exists('g:loaded_skyline')
    finish
endif

let s:save_cpoptions = &cpoptions
let s:skyline_path_options = [ '%t  ', '%{skyline#base#directory()}%t  ' ]

" === User configuration variables ===
let g:loaded_skyline = 1
let g:skyline_mode = get(g:, 'skyline_mode', '0')
let g:skyline_fugitive = get(g:, 'skyline_fugitive', '0')
let g:skyline_ale = get(g:, 'skyline_ale', '0')
let g:skyline_path = get(g:, 'skyline_path', '1')
let g:skyline_fileformat = get(g:, 'skyline_fileformat', '1')
let g:skyline_encoding = get(g:, 'skyline_encoding', '1')
let g:skyline_wordcount = get(g:, 'skyline_wordcount', '0')
let g:skyline_linecount = get(g:, 'skyline_linecount', '0')
let g:skyline_percent = get(g:, 'skyline_percent', '0')
let g:skyline_lineinfo = get(g:, 'skyline_lineinfo', '0')
let g:skyline_filetype = get(g:, 'skyline_filetype', '1')
let g:skyline_bufnum = get(g:, 'skyline_bufnum', '1')
" ======

set cpoptions&vim
set laststatus=2

if g:skyline_mode
    set noshowmode
endif

function! InitStatus()
    let l:statusline='  '

    " === buffer number ===
    if g:skyline_bufnum
        let l:statusline.=':b'.bufnr().' '
    else
        let l:statusline.=' '
    endif

    return l:statusline
endfunction

function! EndStatus()
    let l:statusline=''

    return l:statusline
endfunction

function! ActiveStatus()
    let l:statusline='%#IncSearch#'
    let l:statusline.='%{InitStatus()}'

    " === File path ===
    " g:skyline_pah :: 1 = tail, 2 = full path
    let l:statusline.=s:skyline_path_options[g:skyline_path]

    "=== Dynamic mode color ===
    if g:skyline_mode
        let l:statusline.='%#String#'
        let l:statusline.='%{(mode()=="n")?" NORMAL":""}'
        let l:statusline.='%{(mode()=="c")?" COMMAND":""}'
        let l:statusline.='%#Function#'
        let l:statusline.='%{(mode()=="i")?" INSERT":""}'
        let l:statusline.='%{(mode()=="t")?" TERMINAL":""}'
        let l:statusline.='%#Statement#'
        let l:statusline.='%{(mode()=="v")?" VISUAL":""}'
        let l:statusline.='%{(mode()=="\<C-v>")?" VISUAL BLOCK":""}'
        let l:statusline.='%#Identifier#'
        let l:statusline.='%{(mode()=="R")?" REPLACE":""}'
        let l:statusline.='%{(mode()=="s")?" SELECT":""}'
    endif

    " === Modified, readonly flag ===
    let l:statusline.='%#Comment# %(%M%R%)'
    
    let l:statusline.='%#Normal# '

    " === Divider ===
    let l:statusline.='%='

    " === ALE lint status ===
    if g:skyline_ale
        let l:statusline.='%#String#%(%{skyline#ale#ok()} %)'
        let l:statusline.='%#Error#%(%{skyline#ale#errors()} %)'
        let l:statusline.='%#WarningMsg#%(%{skyline#ale#warnings()} %)'
        let l:statusline.='%#Normal#'
    endif
    
    " === File type ===
    if g:skyline_filetype
        let l:statusline.='%( %{&filetype} %)'
    endif

    " === File format ===
    if g:skyline_fileformat
        let l:statusline.='%( %{skyline#base#fileformat()} %)'
    endif

    " === File encoding ===
    if g:skyline_encoding
        let l:statusline.='%( %{skyline#base#fileencoding()} %)'
    endif

    " === Word count ===
    if g:skyline_wordcount
        let l:statusline.='%( %{skyline#base#wordcount()} words %)'
    endif

    " === Line count ===
    if g:skyline_linecount
        let l:statusline.=' %L lines '
    endif

    " === Relative line number ===
    if g:skyline_percent
        let l:statusline.=' %3p%% '
    endif

    " === Line:column number ===
    if g:skyline_lineinfo
        let l:statusline.=' %3l:%-3c '
    endif

    " === Git branch ===
    if g:skyline_fugitive
        "let l:statusline.='%#Type#'
        let l:statusline.='%( %#Directory#%{skyline#fugitive#branch()}%) '
        "let l:statusline.=' %#Normal# '
    endif

    let l:statusline.='%#IncSearch# %{EndStatus()}'

    return l:statusline
endfunction

function! InactiveStatus()
    let l:statusline='%#StatusLineNC#'
    let l:statusline.='%{InitStatus()}'

    " === File path ===
    " g:skyline_pah :: 1 = tail, 2 = full path
    let l:statusline.=s:skyline_path_options[g:skyline_path]

    " === Modified flag ===
    let l:statusline.='%#Comment# %(%M%)'

    " === Divider ===
    let l:statusline.=' %#Normal#%='

    let l:statusline.=' %{EndStatus()}'

    return l:statusline
endfunction

augroup skyline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveStatus()
    autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveStatus()
augroup END

set statusline=%!ActiveStatus()

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
