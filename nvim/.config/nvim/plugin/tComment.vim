" tcomment_vim
" https://github.com/tomtom/tcomment_vim

" Config
let g:tcomment_maps = 0

" Keymaps
nnoremap <silent> <c-_><c-_> :TComment<cr>
vnoremap <silent> <c-_><c-_> :TCommentMaybeInline<cr>
inoremap <silent> <c-_><c-_> <c-o>:TComment<cr>

nnoremap <silent> <c-_>b :TCommentBlock<cr>
vnoremap <silent> <c-_>b :TCommentBlock<cr>

