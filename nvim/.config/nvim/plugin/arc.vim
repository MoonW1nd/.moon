" " Add sources root directory to path
" if exists("g:ya_vim#arcadia_root")
"     exe "set path+=" . g:ya_vim#arcadia_root
" endif
"
"
" function! GetHgPath()
"     if !exists('g:ya_tool_hg')
"         let g:ya_tool_hg = substitute(system(g:ya_path . ' tool hg --print-path'), '\n', '', '')
"     endif
"     return g:ya_tool_hg
" endfunction()
"
" \ 'hg':       GetHgPath() . ' diff --config extensions.color=! --config defaults.diff= --nodates -U0 -- %f',
let g:signify_vcs_list = get(g:, 'signify_vcs_list', [ 'svn', 'arc', 'hg' ])
let g:signify_vcs_cmds = {
      \ 'arc':      'arc diff --git -U0 -- %f',
      \ 'git':      'git diff --no-color --no-ext-diff -U0 -- %f',
      \ 'svn':      'svn diff --diff-cmd %d -x -U0 -- %f',
      \ 'bzr':      'bzr diff --using %d --diff-options=-U0 -- %f',
      \ 'darcs':    'darcs diff --no-pause-for-gui --diff-command="%d -U0 %1 %2" -- %f',
      \ 'fossil':   'fossil set diff-command "%d -U 0" && fossil diff --unified -c 0 -- %f',
      \ 'cvs':      'cvs diff -U0 -- %f',
      \ 'rcs':      'rcsdiff -U0 %f 2>%n',
      \ 'accurev':  'accurev diff %f -- -U0',
      \ 'perforce': 'p4 info '. sy#util#shell_redirect('%n') .' && env P4DIFF=%d p4 diff -dU0 %f'
      \ }
