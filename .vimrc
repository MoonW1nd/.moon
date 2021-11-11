set nocompatible              " be improved, required
filetype off                  " required
" ============= Vim-Plug ============== "

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,erlang,go"
let g:vim_bootstrap_editor = "nvim"                 " Nvim or Vim

lua require('moonw1nd')

" ==================== general config ======================== "
if (has("termguicolors"))
  set termguicolors
endif
set mouse=                                              " disable mouse

" ===================== Other Configurations ===================== "

let mapleader=" "
filetype plugin indent on                               " enable indentations
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent            " tab key actions
set incsearch ignorecase smartcase hlsearch             " highlight text while searching
set list listchars=tab:→\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»   " use tab to navigate in list mode
set fillchars+=vert:\▏                                  " requires a patched nerd font (try FiraCode)
set wrap breakindent                                    " wrap long lines to the width set by tw
set encoding=utf-8                                      " text encoding
set number                                              " enable numbers on the left
set autowriteall
set relativenumber                                      " current line is 0
set splitright                                          " open vertical split to the right
set splitbelow                                          " open horizontal split to the bottom
set emoji                                               " enable emojis
set undofile                                            " enable persistent undo
set undodir=~/.nvim/tmp                                 " undo temp file directory
set nofoldenable                                        " disable folding
set scrolloff=999                                       " always keep cursor at the middle of screen
set noswapfile                                          " disable creating of *.swp file

set cursorline " highlight cursorline
set nowrap " Не переносить строки
set textwidth=0 " disable auto brset cursorlineeak long lines
set expandtab " Преобразование Tab в пробелы
set path=.,**
set autoread
" for work in insert mod C-w, C-u, C-h, C-k
set backspace=indent,eol,start
" set spell spelllang=ru_ru,en_us

" for yats 
set re=0

" Python Virtual Environment
let g:python_host_prog =  expand('/usr/bin/python')
let g:python3_host_prog = expand('/Library/Frameworks/Python.framework/Versions/3.7/bin/python3')


" Coloring
" set background=light
" colorscheme one
" let g:airline_theme='pencil'
set background=dark
colorscheme onedark
let g:airline_theme='onedark'
" let g:pencil_higher_contrast_ui = 1


highlight clear SignColumn                              " use number color for sign column color

" colors for git (especially the gutter)
" fugitive diff highlight
hi DiffDelete gui=NONE guifg=#6E0004 guibg=#6E0004
hi DiffAdd gui=NONE guifg=NONE guibg=#19381C
hi DiffChange ctermbg=237 guibg=#203C3D cterm=NONE gui=NONE guifg=NONE
hi DiffText ctermbg=237 guibg=#26494A guifg=NONE

" go syntax highlight
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" performance tweaks
" set nocursorline
set nocursorcolumn
set scrolljump=5
set lazyredraw
let g:airline_highlighting_cache=1
set ttyfast

" tmux cursor shape
if exists('$TMUX')
    let &t_SI .= "\ePtmux;\e\e[=1c\e\\"
    let &t_EI .= "\ePtmux;\e\e[=2c\e\\"
 else
    let &t_SI .= "\e[=1c"
    let &t_EI .= "\e[=2c"
 endif

" creating aliace command function
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" ======================== Plugin Configurations ======================== "
" emmet
imap ,, <C-y>,

" [terminus]
let g:TerminusCursorShape=0

" [ultisnips] trigger configuration. 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" [ultisnips] If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" [undotree]
call SetupCommandAlias("ut","UndotreeToggle")

" Ferret
let g:FerretHlsearch=1
let g:FerretMap=0

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" vim-startify
" 'Most Recent Files' number
let g:startify_files_number           = 18

" Update session automatically as you exit vim
let g:startify_session_persistence    = 1

" Simplify the startify list to just recent files and sessions
let g:startify_lists = [
  \ { 'type': 'dir',       'header': ['   Recent files'] },
  \ { 'type': 'sessions',  'header': ['   Saved sessions'] },
  \ ]

" Fancy custom header
let g:startify_custom_header = [
  \ "  ",
  \ '   ╻ ╻   ╻   ┏┳┓',
  \ '   ┃┏┛   ┃   ┃┃┃',
  \ '   ┗┛    ╹   ╹ ╹',
  \ '   ',
  \ ]

" tagalong
let g:tagalong_filetypes = ['html', 'xml', 'jsx', 'eruby', 'ejs', 'eco', 'php', 'htmldjango', 'javascriptreact', 'typescriptreact', 'typescript', 'javascript']

" Nerd Tree
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeCascadeOpenSingleChildDir = 1
let NERDTreeShowBookmarks=1
let g:NERDTreeAutoDeleteBuffer = 1
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=0
" Disable display of the 'Bookmarks' label and 'Press ? for help' text
let NERDTreeMinimalUI=1
" Use arrows instead of + ~ chars when displaying directories
let NERDTreeDirArrows=1
let NERDTreeBookmarksFile= $HOME . '/.vim/.NERDTreeBookmarks'

" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

" Opening position NERDTree
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize = 60

function! NERDTreeToggleAndFind()
    if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
        execute ':NERDTreeClose'
    else
        execute ':NERDTreeFind'
    endif
endfunction

function! ClearAllMarks()
    execute ':delm! | delm A-Z0-9'
endfunction

" hard mode vim active
let g:hardtime_default_on = 1
let g:hardtime_ignore_buffer_patterns = ["NERD.*"]
let g:hardtime_ignore_quickfix = 1
let g:hardtime_maxcount = 2

" Vim rest console 
let g:vrc_curl_opts = {
  \ '--connect-timeout': 10,
  \ '--max-time': 60,
\}

" let g:vrc_split_request_body = 1
" let g:vrc_show_command = 1
let g:vrc_auto_format_response_enabled = 1
let g:vrc_output_buffer_name = '__VRC_OUTPUT.<filetype>'
    let g:vrc_auto_format_response_patterns = {
      \ 'json': 'jq .',
      \ 'xml': 'xmllint --format -',
    \}

" Airline
let g:airline_powerline_fonts = 0
let g:airline#extensions#branch#enabled = 0
let g:airline#themes#clean#palette = 1
call airline#parts#define_raw('linenr', '%l')
call airline#parts#define_accent('linenr', 'bold')
let g:airline_section_z = airline#section#create(['%3p%%  ',
            \ g:airline_symbols.linenr .' ', 'linenr', ':%c '])
let g:airline_section_warning = ''
let g:airline_highlighting_cache = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

" remove go definition by vim-go
let g:go_def_mapping_enabled = 0

set updatetime=300

" Library usedSettings
let g:used_javascript_libs = 'react,ramda'

" Not jums on diagnostics icons
set signcolumn=yes

" lastplace
 let g:lastplace_ignore_buftype = "quickfix,nofile,help"

let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'
let g:netrw_localrmdir='rm -r' " remove derictory from netrw

nmap <silent> <leader>- <Plug>VinegarUp

if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

let g:highlightedyank_highlight_duration = 200

" vim-test
let test#strategy = {
  \ 'nearest': 'asyncrun',
  \ 'file':    'asyncrun',
  \ 'suite':   'asyncrun',
\}

if !exists('g:test#javascript#jest#file_pattern')
  let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test))\.(js|jsx|coffee|ts|tsx)$'
endif

let g:test#javascript#jest#executable = 'BABEL_ENV=test npx jest --maxWorkers=50% --reporters ~/dotfiles/utils/jestVimReporter/index.js'

nmap <leader>oq :copen<cr>
nmap <leader>ol :lopen<cr>

"" FZF
" general
let $FZF_DEFAULT_OPTS="--reverse --bind ctrl-a:select-all" " top to bottom
let $FZF_PREVIEW_COMMAND="bat --style=numbers --map-syntax js:jsx --theme base16 --color=always {} || cat {} || tree -C {}"
" CTRL-A CTRL-Q to select all and build quickfix list
" ======= fzf
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>,  <q-args> == "?" ? {} : fzf#vim#with_preview(), <bang>0)

command! Dab %bd|e#|bd#

" start in a popup
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

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

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-l': function('s:build_location_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" use rg by default
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

command! -bang -nargs=* Rga
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter :'}), <bang>0)

command! -bang -nargs=* GRga
  \ call fzf#vim#grep(
  \   "git diff --name-only --diff-filter=d origin/master | tr '\n' ' ' | xargs rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'options': '--delimiter :'}), <bang>0)

command! -bang Args call fzf#run(fzf#wrap('args',
    \ fzf#vim#with_preview({'source': map([argidx()]+(argidx()==0?[]:range(argc())[0:argidx()-1])+range(argc())[argidx()+1:], 'argv(v:val)')}),<bang>0))

command! -bang GDf call fzf#run(fzf#wrap('args',
    \ fzf#vim#with_preview({'source': "git diff --name-only --diff-filter=d origin/master"}),<bang>0))

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
endif

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
"
" buffer list with fuzzy search

" nnoremap <C-g> :Rga<Space>
" nnoremap <leader><C-g> :GRga<Space>

inoremap <expr> <c-x><c-p> fzf#vim#complete#path('fd')
inoremap <expr> <c-x><c-f> expand("%:t:r")

" fugitive
nmap <leader>g [git-p]
xmap <leader>g [git-p]

nnoremap <silent> [git-p]p :Git push<cr>
nnoremap <silent> [git-p]P :Git push --no-verify<cr>
nnoremap <silent> [git-p]c :Git commit<cr>
nnoremap <silent> [git-p]C :Git commit -n<cr>
nnoremap <silent> [git-p]s :vertical Git<cr>
nnoremap <silent> [git-p]d :Gvdiff<cr>

" Fugitive Conflict Resolution
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" fix open urls
nmap <silent> gx :!open <cWORD><cr>

" arslist
nmap <leader>a [arg-p]
xmap <leader>a [arg-p]

" add current file to arglist
nnoremap <silent> [arg-p]a :arga %<cr>
" delete current file from arglist
nnoremap <silent> [arg-p]d :argd %<cr>
" clear all arglist
nnoremap <silent> [arg-p]c :argd *.*<cr>
" find files in arglist
nnoremap <silent> [arg-p]f :Args<cr>

" Markdown
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
" autocmd FileType markdown set spell
autocmd FileType markdown map <silent> <leader>m :call TerminalPreviewMarkdown()<CR>

" auto html tags closing, enable for markdown files as well
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.md, *.js, *.tsx'

" ================== Custom Functions ===================== "

" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

" markdown files preview inside (you need to install mdv)
function! TerminalPreviewMarkdown()
    vsp | terminal ! mdv %
endfu

" ======================== Custom Mappings ====================== "
nmap <leader>gt :TestFile<CR>

" clever-f.vim support native vim binding for repeat search
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

" nmap <leader>r :so ~/.config/nvim/init.vim<CR>
nmap <leader>q :bd<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <silent> <leader>nf :call NERDTreeToggleAndFind()<CR>
nmap <leader>] :bnext<CR>
nmap <leader>[ :bprevious<CR>

" map for work with location list
nmap ]l :lnext<CR>
nmap [l :lprev<CR>

" Copy current file path to clipboard
nnoremap <leader>% :call CopyCurrentFilePath()<CR>

function! CopyCurrentFilePath() " {{{
  let @+ = expand('%')
  echo @+
endfunction
" }}}

" Keep search results at the center of screen
nmap n nzzzv
nmap N Nzzzv
nmap * *zzzv
nmap # #zzzv
nmap g* g*zzzv
nmap g# g#zzzv
nnoremap J mzJ`z

" Undo with breakpoints
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap : :<c-g>u
inoremap ; ;<c-g>u
inoremap ] ]<c-g>u
inoremap [ [<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d

" noremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k';
" noremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j';

" Select all text
noremap vA ggVG

" Paste without changed "" register
vnoremap <leader>p "_dP

" Move line UP or Down alt-jk
nnoremap ˚ :m .-2<CR>==
nnoremap ∆ :m .+1<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" for project wide search
nmap <leader>/ <Plug>(FerretLack)

" carbon sh now
vnoremap <F8> :CarbonNowSh<CR>

" Creating splits with empty buffers in all directions
nnoremap <Leader>hn :leftabove  vnew<CR>
nnoremap <Leader>ln :rightbelow vnew<CR>
nnoremap <Leader>kn :leftabove  new<CR>
nnoremap <Leader>jn :rightbelow new<CR>

" `SPC l s` - save current session
nnoremap <leader>ls :SSave<CR>

" `SPC l l` - list sessions / switch to different project
nnoremap <leader>lp :SClose<CR>

nnoremap Y yg_;

" ======================== Autocommands ====================== "
" affiliate sync-rsync
command! AffRSync AsyncRun -mode=3 /Users/moonw1nd/Documents/Develop/work/rsync.sh
 
augroup Affiliate
    autocmd BufWritePost /Users/moonw1nd/Documents/Develop/work/affiliate/* :AffRSync
augroup END

command! OpenCurrentTicket silent !~/dotfiles/scripts/openCurrentTicket.sh
command! OpenCurrentBranch silent !~/dotfiles/scripts/openCurrentBranch.sh
command! GhOpenCurrentBranch silent !gh pr view --web

" nnoremap <leader>w :w<CR>:AffRSync<CR>

command! Todo Rga @todo\s\[MoonW1nd]:

command! CreateStyleFile e %:p:h/module.styles.css

" Disable unneeded Ex mode bind that's easy to mistakenly hit
nnoremap Q <NOP>

nnoremap <leader>mn :e %:p:h/
nmap <silent> <leader>ps :rs<CR>

" figitive
call SetupCommandAlias("gs","vertical Git<CR>")
call SetupCommandAlias("td",'Todo')
call SetupCommandAlias("rs",'AffRSync')
call SetupCommandAlias("ot",'OpenCurrentTicket')
call SetupCommandAlias("ob",'OpenCurrentBranch')
call SetupCommandAlias("gob",'GhOpenCurrentBranch')
call SetupCommandAlias("gcn","silent Git commit -n<CR>")
call SetupCommandAlias("gpn","Git push --no-verify<CR>")
call SetupCommandAlias("gmt","G mergetool")
call SetupCommandAlias("gdt","G difftool")
call SetupCommandAlias("gr","Rg")
call SetupCommandAlias("gra","Rga")
call SetupCommandAlias("dab","Dab")
call SetupCommandAlias("cam","call ClearAllMarks()")

augroup fugitiveSettings
    autocmd!
    autocmd FileType gitcommit setlocal nolist
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
augroup END

" save on focus lost
au FocusLost * silent! wa

" command! Prettier call CocAction('runCommand', 'prettier.formatFile')

" hi SpellBad guifg=NONE cterm=undercurl

hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white

autocmd BufWritePre *.{js,jsx,ts,tsx,cjs,mjs} :silent EslintFixAll
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufNewFile,BufRead tsconfig.json set filetype=jsonc
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript

" Plugin settings
source ~/.config/nvim/plugin/init.vim
