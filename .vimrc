set nocompatible              " be improved, required
filetype off                  " required
" ============= Vim-Plug ============== "

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,erlang,go"
let g:vim_bootstrap_editor = "nvim"                 " Nvim or Vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"
  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.config/nvim/plugged'))

" ================= looks and GUI stuff ================== "

Plug 'vim-airline/vim-airline'                          " airline status bar
Plug 'vim-airline/vim-airline-themes'                   " airline themes
Plug 'ryanoasis/vim-devicons'                          " pretty icons everywhere
Plug 'gregsexton/MatchTag'                              " highlight matching html tags
Plug 'preservim/nerdtree'                               " nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'          " nerdtree color file names
Plug 'Xuyuanp/nerdtree-git-plugin'                      " git-nerdtree
Plug 'tpope/vim-vinegar'                                " navigation tree from the current file
Plug 'blueyed/vim-diminactive'                          " dim inactive splits
Plug 'editorconfig/editorconfig-vim'                    " consistent coding style

" ================= Functionalities ================= "

Plug 'neoclide/coc.nvim', {'branch': 'release'}         " auto completion, Lang servers and stuff
Plug 'lyokha/vim-xkbswitch'                             " auto switch keyboard map
Plug 'skywind3000/asyncrun.vim'                         " async run commands
Plug 'moonw1nd/vim-rest-console'                           " REST client
Plug 'vim-test/vim-test'

" " search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'                                " fuzzy search integration
Plug 'wincent/ferret'
Plug 'majutsushi/tagbar'                               " tags map on current file

" navigation
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'                        " make movement a lot faster and easier
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-unimpaired'
Plug 'Shougo/neomru.vim'
Plug 'kshenoy/vim-signature'

" " visual
Plug 'joshdick/onedark.vim'                             " theme OneDark
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'

" " languages
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'neoclide/jsonc.vim'
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'           " highlight libraries
Plug 'alexlafroscia/postcss-syntax.vim'
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'javascript', 'typescript'] }
"
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" " other
Plug 'machakann/vim-highlightedyank'                    " highlight yanked file
Plug 'alvan/vim-closetag'                               " auto close html tags
Plug 'AndrewRadev/tagalong.vim'                         " rename tags
Plug 'sjl/gundo.vim'                                    " undo tree in vim
Plug 'vim-scripts/ReplaceWithRegister'                  " replace word on copy buffer
Plug 'tpope/vim-surround'                               " surround brackets
Plug 'takac/vim-hardtime'                               " hard mode on vim
Plug 'tomtom/tcomment_vim'                              " better commenting
Plug 'kristijanhusak/vim-carbon-now-sh'                 " lit code Screenshots
Plug 'tpope/vim-fugitive'                               " git support
Plug 'farmergreg/vim-lastplace'                         " open files at the last edited place
Plug 'romainl/vim-cool'                                 " disable hl until another search is performed
Plug 'wellle/tmux-complete.vim'                         " complete words from a tmux panes
call plug#end()


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
set spell spelllang=ru_ru,en_us

" for yats 
set re=0

" ========== tagbar
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_show_linenumbers = 2
let g:tagbar_type_javascript = {
      \ 'ctagstype': 'javascript',
      \ 'kinds': [
      \ 'A:arrays',
      \ 'P:properties',
      \ 'T:tags',
      \ 'O:objects',
      \ 'G:generator functions',
      \ 'U:functions',
      \ 'K:constructors/classes',
      \ 'M:methods',
      \ 'V:variables',
      \ 'I:imports',
      \ 'E:exports',
      \ 'S:styled components'
      \ ]}

let g:tagbar_type_css = {
\ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
\ }

" Python Virtual Environment
let g:python_host_prog =  expand('/usr/bin/python')
let g:python3_host_prog = expand('/Library/Frameworks/Python.framework/Versions/3.7/bin/python3')


" Coloring
set background=dark
colorscheme onedark
let g:airline_theme='onedark'
highlight clear SignColumn                              " use number color for sign column color
hi EasyMotionMoveHLDefault gui=NONE cterm=NONE term=NONE ctermfg=235 ctermbg=180 guifg=#282C34 guibg=#E5C07B

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
" switch keyboard enabled
let g:XkbSwitchEnabled = 1
let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.dylib'
" fix errors on airlaine
" let g:XkbSwitchIMappings = ['ru', 'de']
" let g:XkbSwitchIMappingsTr = {
"           \ 'ru':
"           \ {'<': 'qwertyuiop[]asdfghjkl;''zxcvbnm,.`/'.
"           \       'QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?~@#$^&|',
"           \  '>': 'йцукенгшщзхъфывапролджэячсмитьбюё.'.
"           \       'ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,Ё"№;:?/'},
"           \ 'de':
"           \ {'<': 'yz-[];''/YZ{}:"<>?~@#^&*_\',
"           \  '>': 'zyßü+öä-ZYÜ*ÖÄ;:_°"§&/(?#'},
"           \ }

" emmet
imap ,, <C-y>,

" Gundo.vim
let g:gundo_right = 1
call SetupCommandAlias("ut","GundoToggle")

" Ferret
let g:FerretHlsearch=1

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
let g:airline#themes#clean#palette = 1
call airline#parts#define_raw('linenr', '%l')
call airline#parts#define_accent('linenr', 'bold')
let g:airline_section_z = airline#section#create(['%3p%%  ',
            \ g:airline_symbols.linenr .' ', 'linenr', ':%c '])
let g:airline_section_warning = ''
let g:airline#extensions#ale#enabled = 1                " ALE integration
let airline#extensions#vista#enabled = 1                " vista integration

" remove go definition by vim-go
let g:go_def_mapping_enabled = 0

set updatetime=300

" Library usedSettings
let g:used_javascript_libs = 'react,ramda'

" ========== nvim-coc settings ============= "
let g:coc_node_path = $HOME . '/.nvm/versions/node/v12.10.0/bin/node'
" привет мир
" list of the extensions required
let g:coc_global_extensions = [
            \'coc-pairs',
            \'coc-json',
            \'coc-css',
            \'coc-html',
            \'coc-tsserver',
            \'coc-yaml',
            \'coc-lists',
            \'coc-python',
            \'coc-xml',
            \'coc-cssmodules',
            \'coc-prettier',
            \'coc-eslint',
            \'coc-stylelintplus',
            \]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> <leader>- <Plug>VinegarUp

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> ga <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" lastplace
 let g:lastplace_ignore_buftype = "quickfix,nofile,help"

" tagbar
let g:tagbar_autofocus = 1

" easymotion
let g:EasyMotion_startofline = 0                        " keep cursor column when JK motion
let g:EasyMotion_smartcase = 1                          " ignore case

if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

let g:highlightedyank_highlight_duration = 200

" vim-test
let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'basic',
  \ 'suite':   'basic',
\}

let g:test#javascript#jest#executable = 'BABEL_ENV=test npx jest'

"" FZF
" general
let $FZF_DEFAULT_OPTS="--reverse --bind ctrl-a:select-all" " top to bottom
let $FZF_PREVIEW_COMMAND="bat --style=numbers --map-syntax js:jsx --theme base16 --color=always {} || cat {} || tree -C {}"
" CTRL-A CTRL-Q to select all and build quickfix list
" ======= fzf
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>,  <q-args> == "?" ? {} : fzf#vim#with_preview(), <bang>0)

command! Dab %bd|e#|bd#

nmap <leader>f [fzf-p]
xmap <leader>f [fzf-p]

" user leader f to search for not ignored file paths
nnoremap <silent> [fzf-p]p :GFiles<cr>
nnoremap <silent> [fzf-p]b :Buffers<cr>
nnoremap <silent> [fzf-p]s :Snippets<cr>
nnoremap <silent> [fzf-p]w :Windows<cr>
nnoremap <silent> [fzf-p]h :History<cr>
nnoremap <silent> [fzf-p]g :Rg<cr>
nnoremap <silent> [fzf-p]a :Files dev/api/<cr>
" buffer list with fuzzy search
nnoremap <leader>gs :GFiles?<cr>
nnoremap <silent> <leader>t :TagbarToggle<cr>

nmap <silent> gcb :TCommentBlock<cr>
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

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
endif

nnoremap <C-g> :Rga<Space>

" Markdown
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType markdown set spell
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

" fugitive
" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" clever-f.vim support native vim binding for repeat search
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

nmap <leader>r :so ~/.config/nvim/init.vim<CR>
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
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Select all text
noremap vA ggVG

" Move line UP or Down
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=g

" for project wide search
nmap <leader>/ <Plug>(FerretLack)

" carbon sh now
vnoremap <F8> :CarbonNowSh<CR>

" quick navigation
map <Leader><Leader>l <Plug>(easymotion-lineforward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><Leader>h <Plug>(easymotion-linebackward)

" Creating splits with empty buffers in all directions
nnoremap <Leader>hn :leftabove  vnew<CR>
nnoremap <Leader>ln :rightbelow vnew<CR>
nnoremap <Leader>kn :leftabove  new<CR>
nnoremap <Leader>jn :rightbelow new<CR>

" `SPC l s` - save current session
nnoremap <leader>ls :SSave<CR>

" `SPC l l` - list sessions / switch to different project
nnoremap <leader>lp :SClose<CR>

" ======================== Autocommands ====================== "
" affiliate sync-rsync
augroup Affiliate
    autocmd BufWritePost /Users/moonw1nd/Documents/Develop/work/affiliate/* silent! :AsyncRun /Users/moonw1nd/Documents/Develop/work/rsync.sh
augroup END

" figitive
call SetupCommandAlias("gs","Gstatus<CR><C-w>30+")
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

command! Prettier call CocAction('runCommand', 'prettier.formatFile')

hi SpellBad guifg=NONE cterm=undercurl

hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white

autocmd BufNewFile,BufRead tsconfig.json set filetype=jsonc
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
