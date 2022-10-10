if exists('g:loaded_hackline') | finish | endif
let g:loaded_hackline = v:true
let s:save_cpo = &cpo

set cpo&vim

if &laststatus != 3 | exe('set laststatus=' . hackline#config#laststatus()) | endif

call hackline#init()

let &cpo = s:save_cpo

unlet s:save_cpo
