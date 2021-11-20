" https://github.com/antonk52/dirvish-fs.vim

let g:dirvish_relative_paths = 1

" folders on top
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'

" disables default mappings
let g:dirvish_fs_default_mappings = 0

" sets custom mappings
function! DivrishMappings()
    nmap <buffer> <silent>dd <Plug>DirvishFsRemove
    nmap <buffer> <silent>ma <Plug>DirvishFsAdd
    nmap <buffer> <silent>mm <Plug>DirvishFsMove
    nmap <buffer> <silent>mc <Plug>DirvishFsCopy
endfunction

unmap -
nmap <silent><leader>- <Plug>(dirvish_up)

autocmd FileType dirvish call DivrishMappings()
