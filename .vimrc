" Plugin settings
" vimscript ./nvim/.config/nvim/plugin/
" lua ./nvim/.config/nvim/lua/moonw1nd/

" 
" Required settings for correct work
"
set nocompatible
filetype off


"
" Vim Plugin manager
"
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

" load lua configs and plugins
lua require('moonw1nd')


"
" Editor behoviour settings
"
let mapleader=" "
let maplocalleader="\\"

" disable mouse
set mouse=

" enable indentations
filetype plugin indent on

" tab key actions
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent

" highlight text while searching
set incsearch ignorecase smartcase hlsearch

" use tab to navigate in list mode
set list listchars=tab:→\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»

" requires a patched nerd font (try FiraCode)
set fillchars+=vert:\▏

" wrap long lines to the width set by tw
set wrap breakindent

" text encoding
set encoding=utf-8

" enable numbers on the left
set number

" current line is 0
set relativenumber

" open vertical split to the right
set splitright

" open horizontal split to the bottom
set splitbelow

" enable emojis
set emoji

" enable persistent undo
set undofile

" undo temp file directory
set undodir=~/.nvim/tmp

" disable creating of *.swp file
set noswapfile

" off spell cheeck
set nospell

" folding settings
set foldmethod=indent
set foldlevel=99
" use wider line for folding
set fillchars+=fold:-

" highlight cursorline
set cursorline

" set nocursorline
set nocursorcolumn

" no wrap lines
set nowrap
set textwidth=0 " disable auto brset cursorlineeak long lines

" tab -> space
set expandtab

" file path resolving settings
set path=.,**

" detect filechanges outside of the editor
set autoread
set autowriteall

" never ring the bell for any reason
set belloff=all

" for work in insert mod C-w, C-u, C-h, C-k
set backspace=indent,eol,start

" for yats @todo remove?
set re=0

" Not jums on diagnostics icons
set signcolumn=yes

" set shell for run commands (zsh - slow)
set shell=bash

if (has("termguicolors"))
  set termguicolors
endif

" === netrw ===
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

" remove derictory from netrw
let g:netrw_localrmdir='rm -r'

"
" Perfomance tweaks
"
set scrolljump=5
set lazyredraw
let g:airline_highlighting_cache=1
set ttyfast
set updatetime=300


"
" Theme settings
"
" === Dark Theme ===
set background=dark
colorscheme onedark
let g:airline_theme='onedark'

" === Light theme ===
" set background=light
" let g:airline_theme='pencil'
" let g:pencil_higher_contrast_ui = 1

" use number color for sign column color
highlight clear signcolumn

" === Tmux cursor shape ===
if exists('$TMUX')
    let &t_SI .= "\ePtmux;\e\e[=1c\e\\"
    let &t_EI .= "\ePtmux;\e\e[=2c\e\\"
 else
    let &t_SI .= "\e[=1c"
    let &t_EI .= "\e[=2c"
 endif


"
" Keybindings
"
" === Always keep cursor at the middle of screen ===
set scrolloff=999
nmap n nzzzv
nmap N Nzzzv
nmap * *zzzv
nmap # #zzzv
nmap g* g*zzzv
nmap g# g#zzzv
nnoremap J mzJ`z


" === Undo with breakpoints ===
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap : :<c-g>u
inoremap ; ;<c-g>u
inoremap ] ]<c-g>u
inoremap [ [<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u


" === Move line UP or Down alt-jk ===
nnoremap ˚ :m .-2<CR>==
nnoremap ∆ :m .+1<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Disable unneeded Ex mode bind that's easy to mistakenly hit
nnoremap Q <NOP>

" Fix open urls
nmap <silent> gx :!open <cWORD><cr>

" Consistent behoviour Y (copy to end line)
nnoremap Y yg_;

" Easy copy to shared register
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_

" Delete withoit change register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Paste without changed register
vnoremap <leader>p "_dP

" paste under current indentation level
nnoremap p ]p
nnoremap P ]P

" indentation shifts keep selection(`=` should still be preferred)
vnoremap < <gv
vnoremap > >gv

" Select all text
noremap vA ggVG

" Create new file in current folder
nnoremap <leader>mn :e %:p:h/

" Open style file
nnoremap <leader>os :e %:p:h/styles.module.css<cr>
" Open index file
nnoremap <leader>oi :e %:p:h/index.*<cr>

" Open quickfix and location list
nmap <leader>oq :copen<cr>
nmap <leader>ol :lopen<cr>

" Start substitution path @todo delete? Not usefull
inoremap <expr> <c-x><c-p> fzf#vim#complete#path('fd')

" Past current file name
inoremap <expr> <c-x><c-f> expand("%:t:r")

" Very magic substitution mode
nnoremap <leader>s :%smagic/

"
" Plugin Configurations 
"
" [terminus]
let g:TerminusCursorShape=0

" Ferret
let g:FerretHlsearch=1
let g:FerretMap=0

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

" Tagalong rename tags Plugin
let g:tagalong_filetypes = ['html', 'xml', 'jsx', 'eruby', 'ejs', 'eco', 'php', 'htmldjango', 'javascriptreact', 'typescriptreact', 'typescript', 'javascript']

function! ClearAllMarks()
    execute ':delm! | delm A-Z0-9'
endfunction

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

" Library usedSettings
let g:used_javascript_libs = 'react,ramda'

" lastplace
let g:lastplace_ignore_buftype = "quickfix,nofile,help"

if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

let g:highlightedyank_highlight_duration = 200

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
nnoremap <leader>s :%smagic/


" Markdown
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
" autocmd FileType markdown set spell
autocmd FileType markdown map <silent> <leader>m :call TerminalPreviewMarkdown()<CR>

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

" clever-f.vim support native vim binding for repeat search
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

" nmap <leader>r :so ~/.config/nvim/init.vim<CR>
nmap <leader>q :bd<CR>

" map for work with location list
nmap ]l :lnext<CR>
nmap [l :lprev<CR>

" Copy current file path to clipboard
nnoremap <leader>% :call CopyCurrentFilePath()<CR>

function! CopyCurrentFilePath()
  let @+ = expand('%')
  echo @+
endfunction

" for project wide search
nmap <leader>/ <Plug>(FerretLack)

" carbon sh now
vnoremap <F8> :CarbonNowSh<CR>

" `SPC l s` - save current session
nnoremap <leader>ls :SSave<CR>

" `SPC l l` - list sessions / switch to different project
nnoremap <leader>lp :SClose<CR>

nmap <silent> <leader>ps :rs<CR>

" ======================== Autocommands ====================== "
" affiliate sync-rsync
command! AffRSync AsyncRun -mode=3 /Users/moonw1nd/Documents/Develop/work/rsync.sh

command! OpenCurrentTicket silent !~/dotfiles/scripts/openCurrentTicket.sh
command! OpenCurrentBranch silent !~/dotfiles/scripts/openCurrentBranch.sh
command! GhOpenCurrentBranch silent !gh pr view --web
command! GhOpenFile silent !gh browse %
command! RebuildServer silent !ssh $REMOTE_DEV_SERVER -t 'tmux send-keys -t 0 C-c;tmux send-keys "make clean && git checkout . && git pull -r origin master" C-m;tmux send-keys "nvm use 12 && make && make hmr-server" C-m'
command! ReloadServer silent !ssh $REMOTE_DEV_SERVER -t 'tmux send-keys -t 0 C-c; tmux send-keys "make hmr-server" C-m'
command! ReloadWebpack !tmux send-keys -t "[affiliate]:1.0" C-c "make hmr-client" C-m
command! SyncAndReloadServer AsyncRun -mode=3 /Users/moonw1nd/Documents/Develop/work/rsync.sh && ssh $REMOTE_DEV_SERVER -t 'tmux send-keys -t 0 C-c; tmux send-keys "make hmr-server" C-m'

" Delete all buffers
command! Dab %bd|e#|bd#

command! Todo Rga @todo\s\[MoonW1nd]:
command! CreateStyleFile e %:p:h/styles.module.css
command! -nargs=1 RunTestAA :AsyncRun npm run test -- --maxWorkers=50\% --reporters ~/dotfiles/utils/jestVimReporter/index.js --testNamePattern='candidate' <q-args>


autocmd FocusLost * silent! wa
autocmd BufWritePre *.{js,jsx,ts,tsx,cjs,mjs} :silent EslintFixAll
autocmd BufWritePre *.{css} :silent lua vim.lsp.buf.formatting()
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua require("moonw1nd.lsp.go").goimports(1000)
autocmd BufNewFile,BufRead tsconfig.json set filetype=jsonc
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript

function! MyFoldText()
    let l:start_arrow = '----► '
    let l:lines='[' . (v:foldend - v:foldstart + 1) . ' lines]'
    let l:first_line=substitute(getline(v:foldstart), '\v *', '', '')
    return l:start_arrow . l:lines . ': ' . l:first_line . ' '
endfunction

" Custom display for text when folding
set foldtext=MyFoldText() 

" toggle folding
nmap <leader>= za

"
" @todo WTF?
" Artefacts
"
" let g:vim_bootstrap_langs = "c,erlang,go"
" let g:vim_bootstrap_editor = "nvim"
" hi SpellBad guifg=NONE cterm=undercurl
