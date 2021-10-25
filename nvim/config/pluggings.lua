-- Plugins

-- load vim plug if it is not installed
if vim.fn.empty(vim.fn.glob('~/.config/nvim/autoload/plug.vim')) == 1 then
    vim.cmd('silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

local Plug = vim.fn['plug#']

vim.fn['plug#begin']('~/.config/nvim/plugged')

-- ================= looks and GUI stuff ==================

Plug('vim-airline/vim-airline')                         -- airline status bar
Plug('vim-airline/vim-airline-themes')                   -- airline themes
Plug('ryanoasis/vim-devicons')                          -- pretty icons everywhere
Plug('gregsexton/MatchTag')                              -- highlight matching html tags
Plug('preservim/nerdtree')                               -- nerdtree
Plug('tiagofumo/vim-nerdtree-syntax-highlight')          -- nerdtree color file names
Plug('Xuyuanp/nerdtree-git-plugin')                      -- git-nerdtree
Plug('tpope/vim-vinegar')                                -- navigation tree from the current file
Plug('blueyed/vim-diminactive')                          -- dim inactive splits
Plug('editorconfig/editorconfig-vim')                    -- consistent coding style

-- ================= Functionalities ================= 

-- Plug('neoclide/coc.nvim', {['branch'] = 'release'})         -- auto completion, Lang servers and stuff
Plug('skywind3000/asyncrun.vim')                         -- async run commands
Plug('moonw1nd/vim-rest-console')                        -- REST client
Plug('SirVer/ultisnips')                                 -- snippets
Plug('vim-test/vim-test')

-- Native LSP Support
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/nvim-cmp')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('nvim-treesitter/playground')

-- searc
Plug('junegunn/fzf', { ['dir'] = '~/.fzf', ['do'] = './install --all' })
Plug('junegunn/fzf.vim')                                -- fuzzy search integration
Plug('wincent/ferret')

-- navigation
Plug('tpope/vim-repeat')
Plug('rhysd/clever-f.vim')
Plug('tpope/vim-unimpaired')
Plug('bkad/CamelCaseMotion')                           -- Modify movement by w
Plug('kshenoy/vim-signature')                            -- display marks

-- -- visual
Plug('joshdick/onedark.vim')                             -- dark theme
Plug('preservim/vim-colors-pencil')                      -- light theme
Plug('mhinz/vim-startify')
Plug('airblade/vim-gitgutter')

-- -- languages
Plug('godlygeek/tabular')
Plug('plasticboy/vim-markdown')
Plug('iamcco/markdown-preview.nvim', { ['do'] = 'cd app & npm install', ['for'] = {'markdown', 'mdx'} })
Plug('mattn/emmet-vim', { ['for'] = { 'html', 'css', 'javascript', 'typescript' } })
--
Plug('fatih/vim-go', { ['do'] = ':GoUpdateBinaries' })
-- -- other
Plug('wellle/targets.vim')                               -- improve text objects API
Plug('machakann/vim-highlightedyank')                    -- highlight yanked file
Plug('alvan/vim-closetag')                               -- auto close html tags
Plug('AndrewRadev/tagalong.vim')                         -- rename tags
Plug('sjl/gundo.vim')                                    -- undo tree in vim
Plug('vim-scripts/ReplaceWithRegister')                  -- replace word on copy buffer
Plug('tpope/vim-surround')                               -- surround brackets
Plug('takac/vim-hardtime')                               -- hard mode on vim
Plug('tomtom/tcomment_vim')                              -- better commenting
Plug('kristijanhusak/vim-carbon-now-sh')                 -- lit code Screenshots
Plug('tpope/vim-fugitive')                               -- git support
Plug('farmergreg/vim-lastplace')                         -- open files at the last edited place
Plug('romainl/vim-cool')                                 -- disable hl until another search is performed
-- Plug('wellle/tmux-complete.vim')                         -- complete words from a tmux panes
Plug('wincent/terminus')                                 -- sensible defaults

vim.fn['plug#end']()
