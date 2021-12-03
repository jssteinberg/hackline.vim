if exists('g:loaded_hackline') | finish | endif
let g:loaded_hackline = v:true

let s:save_cpo = &cpo
set cpo&vim

let s:hackline_path_options = [ '%t ', '%f' ]
let b:hackline_set_ale=0

" === User configuration variables ===
let g:hackline_bufnum = get(g:, 'hackline_bufnum', '1')
let g:hackline_path = get(g:, 'hackline_path', '1')
let g:hackline_mode = get(g:, 'hackline_mode', '1')
let g:hackline_fugitive = get(g:, 'hackline_fugitive', '1')
let g:hackline_fileformat = get(g:, 'hackline_fileformat', '1')
let g:hackline_encoding = get(g:, 'hackline_encoding', '1')
let g:hackline_filetype = get(g:, 'hackline_filetype', '1')
let g:hackline_filesize = get(g:, 'hackline_lineinfo', '0')
let g:hackline_wordcount = get(g:, 'hackline_wordcount', '0')
let g:hackline_linecount = get(g:, 'hackline_linecount', '1')
let g:hackline_percent = get(g:, 'hackline_percent', '0')
let g:hackline_lineinfo = get(g:, 'hackline_lineinfo', '0')

set laststatus=2
if g:hackline_mode | set noshowmode | endif

aug hackline
    au!
    au WinEnter,BufEnter * setlocal statusline=%!ActiveStatus()
    au WinLeave,BufLeave * setlocal statusline=%!InactiveStatus()
    au User ALEJobStarted let b:hackline_set_ale=1
aug END

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

    let l:statusline.=' %#Comment#'
    let l:statusline.='%{%StatusLinterLsp()%}'
    
    " === Git branch ===
    if g:hackline_fugitive
        let l:statusline.='%#Directory#'
        let l:statusline.='%( %{hackline#fugitive#branch()} %)'
    endif

    let l:statusline.=' %#Normal#'
    let l:statusline.='%#CursorLine# '
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

    let l:statusline.='%#StatusLineNC#%= '
    let l:statusline.='%{%StatusBufMisc()%} '

    if g:hackline_percent || g:hackline_lineinfo
        let l:statusline.='%#StatusLineNC#'
        let l:statusline.='%{%StatusEnd()%}'
    endif

    return l:statusline
endfunction

function! StatusStart()
    let l:statusline='   '

    " === Buffer number ===
    if g:hackline_bufnum
        let l:statusline.=':b'.bufnr().' '
    endif

    return l:statusline
endfunction

function! StatusLinterLsp()
    let l:ale_linters=''
    let l:lsp_linters=''
    let l:statusline=''

    try " destructure g:ale_buffer_info
        let l:ale_linters.=reduce(get(get(g:ale_buffer_info, buffer_number()), 'loclist'), { acc, val -> acc.' '.val['linter_name'] }, '')
    catch | endtry

    try " destructure g:ale_buffer_info TODO: test vim without lua
        "vim.lsp.get_active_clients()
        let l:lsp_linters.=luaeval("require('hackline.lsp').servers()")
    catch | endtry

    " === Linter status ===
    if l:ale_linters != ''
        "let l:statusline.=' ALE'.l:ale_linters.' '
        let l:statusline.=' ALE '
    elseif exists('b:hackline_set_ale') && b:hackline_set_ale == 1
        " ALE linter is active
        let l:statusline.=' ALE '
    endif

    if l:lsp_linters != ''
        let l:statusline.=' LSP'.l:lsp_linters.' '
    endif

    return l:statusline
endfunction

function! StatusBufMisc()
    let l:statusline=''

    " === File type ===
    if g:hackline_filetype
        let l:statusline.=' '.hackline#base#filetype().' '
    endif

    " === File format ===
    if g:hackline_fileformat
        let l:statusline.=' '.hackline#base#fileformat().' '
    endif

    " === File encoding ===
    if g:hackline_encoding
        let l:statusline.=' '.hackline#base#fileencoding().' '
    endif

    " === File size ===
    if g:hackline_filesize
        let l:statusline.=' '.hackline#base#filesize().' '
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

let &cpo = s:save_cpo
unlet s:save_cpo
