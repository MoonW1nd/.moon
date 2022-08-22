" FZF
" @see https://github.com/junegunn/fzf.vim

" General
set grepprg=rg\ --vimgrep

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let $FZF_DEFAULT_OPTS="--reverse --bind ctrl-a:select-all"
let $FZF_PREVIEW_COMMAND="bat --style=numbers --map-syntax js:jsx --theme base16 --color=always {} || cat {} || tree -C {}"

" Functions
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

function! s:build_location_list(lines)
  call setloclist(0, map(copy(a:lines), '{ "filename": v:val }'))
  lopen
  ll
endfunction

" Settings
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-l': function('s:build_location_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Commands
command! -bang -nargs=* Find call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>,  <q-args> == "?" ? {} : fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

command! -bang -nargs=* Rga
  \ call fzf#vim#grep(
  \   'rg --column --hidden --line-number --no-heading --color=always --glob="!node_modules" --glob="!app" --glob="!freeze" --glob="!coverage" --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter :'}), <bang>0)

command! -bang -nargs=* GRga
  \ call fzf#vim#grep(
  \   "git diff --name-only --diff-filter=d origin/master | tr '\n' ' ' | xargs rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'options': '--delimiter :'}), <bang>0)

command! -bang Args call fzf#run(fzf#wrap('args',
    \ fzf#vim#with_preview({'source': map([argidx()]+(argidx()==0?[]:range(argc())[0:argidx()-1])+range(argc())[argidx()+1:], 'argv(v:val)')}),<bang>0))

command! -bang GDf call fzf#run(fzf#wrap('args',
    \ fzf#vim#with_preview({'source': "git diff --name-only --diff-filter=d origin/master"}),<bang>0))

" Damp Mappings

" nmap <leader>f [fzf-p]
" xmap <leader>f [fzf-p]

" user leader f to search for not ignored file paths
" nnoremap <silent> [fzf-p]p :GFiles<cr>
" nnoremap <silent> [fzf-p]P :GDf<cr>
" nnoremap <silent> [fzf-p]b :Buffers<cr>
" nnoremap <silent> [fzf-p]s :Snippets<cr>
" nnoremap <silent> [fzf-p]w :Windows<cr>
" nnoremap <silent> [fzf-p]h :History<cr>
" nnoremap <silent> [fzf-p]g :Rg<cr>
" nnoremap <silent> [fzf-p]a :Args<cr>
" nnoremap <silent> [fzf-p]f :GFiles?<cr>
" nnoremap <silent> [fzf-p]r :Files ~/.dev/api/<cr>

nnoremap <C-g> :Rga<Space>
" nnoremap <leader><C-g> :GRga<Space>
