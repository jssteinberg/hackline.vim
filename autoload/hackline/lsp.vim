function! hackline#lsp#status()
    let l:lsp_linters=''
    let l:statusline=''

    try " destructure g:ale_buffer_info TODO: test vim without lua
        let l:lsp_linters.=luaeval("require('hackline.lsp').servers()")
    catch | endtry

    if l:lsp_linters != ''
        let l:statusline.='LSP:'.l:lsp_linters.''
    endif

    return l:statusline
endfunction
