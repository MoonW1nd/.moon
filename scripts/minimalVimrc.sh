# Config vimrc for work with ssh and fast open editor in CLI commands

export MINIMAL_VIMINIT='
set mouse=
let mapleader=" "
filetype plugin indent on
set rtp=~/dotfiles/.vimrc
set tabstop=4 softtabstop=4 shiftwidth=4 shiftround expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set fillchars+=vert:\▏
set wrap breakindent
set encoding=utf-8
set number
set relativenumber
set splitright
set splitbelow
set emoji
set noswapfile
set nospell
set foldmethod=indent
set foldlevel=99
set fillchars+=fold:-
set cursorline
set nocursorcolumn
set nowrap
set textwidth=0
set expandtab
set path=.,**
set autoread
set autowriteall
set belloff=all
set backspace=indent,eol,start
set re=0
set signcolumn=yes
set scrolljump=5
set lazyredraw
set ttyfast
set updatetime=300
set scrolloff=999
nmap n nzzzv
nmap N Nzzzv
nmap * *zzzv
nmap # #zzzv
nmap g* g*zzzv
nmap g# g#zzzv
nnoremap J mzJ`z
nnoremap Q <NOP>
nmap <leader>n :nohl<CR>
nnoremap Y yg_;
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap <leader>p "_dP
nnoremap p ]p
nnoremap P ]P
vnoremap < <gv
vnoremap > >gv
noremap vA ggVG
nnoremap <leader>mn :e %:p:h/
nmap <leader>oq :copen<cr>
nmap <leader>ol :lopen<cr>
nnoremap <leader>s :%smagic/
highlight clear signcolumn
hi Visual cterm=none ctermbg=238
hi CursorLine cterm=none ctermbg=235
'
