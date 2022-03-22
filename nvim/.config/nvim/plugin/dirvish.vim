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
    nmap <buffer> <silent>os :Dirvish $PWD/src/<CR>
    nmap <buffer> <silent>oh :Dirvish $PWD<CR>

    nnoremap <silent><buffer> l :<C-U>.call dirvish#open("edit", 0)<CR>
    noremap <silent><buffer> h :<C-U>exe "Dirvish %:h".repeat(":h",v:count1)<CR>
endfunction

unmap -
nmap <silent><leader>- <Plug>(dirvish_up)
nmap <silent><leader>_ :Vifm<CR>
nmap <silent><leader>v- <Plug>(dirvish_split_up)
nmap <silent><leader>v_ :VsplitVifm<CR>

autocmd FileType dirvish call DivrishMappings()
