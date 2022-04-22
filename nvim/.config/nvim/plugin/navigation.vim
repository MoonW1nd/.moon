nmap <silent><leader>_ :Vifm<CR>
nmap <silent><leader>v_ :VsplitVifm<CR>

" DWM mappings
" nmap <C-J> <Plug>DWMRotateCounterclockwise
" nmap <C-K> <Plug>DWMRotateClockwise

" nmap <C-L> <Plug>DWMGrowMaster
" nmap <C-H> <Plug>DWMShrinkMaster

" nmap <C-N> <Plug>DWMNew
" nmap <C-M> <Plug>DWMFocus

" nmap <C-C> <Plug>DWMClose

" Open style file
nnoremap <leader>os :e %:p:h/styles.module.css<cr>

" Open index file
nnoremap <leader>oi :e %:p:h/index.*<cr>

" Open index file
nnoremap <leader>ofs :Dirvish $PWD/src/<cr>

nnoremap <leader>fm :lua require("moonw1nd.work").home_module()<cr>
