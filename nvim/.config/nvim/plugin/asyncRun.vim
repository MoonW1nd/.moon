" AsynRun
" https://github.com/skywind3000/asyncrun.vim

" Set error format for quickfix
" TypeScript
set efm+=%E\ %#%f\ %#(%l\\\,%c):\ error\ TS%n:\ %m,%C%m

let g:asyncrun_open = 8

command! MakeTs AsyncRun npx tsc --noEmit -p $PWD
command! MakeEslintFile AsyncRun $PWD/node_modules/.bin/eslint -f unix %
command! MakeEslint AsyncRun $PWD/node_modules/.bin/eslint -f unix $PWD


