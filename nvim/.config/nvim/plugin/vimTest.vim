" Vim-test
let test#strategy = {
  \ 'nearest': 'asyncrun',
  \ 'file':    'asyncrun',
  \ 'suite':   'asyncrun',
\}

if !exists('g:test#javascript#jest#file_pattern')
  let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test))\.(js|jsx|coffee|ts|tsx)$'
endif

let g:test#javascript#jest#executable = 'BABEL_ENV=test npx jest --maxWorkers=50% --reporters ~/dotfiles/utils/jestVimReporter/index.js'

nmap <leader>gt :TestFile<CR>
