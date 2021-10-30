" import by realative path
function! Source(relativePath)
  let user = expand('$USER')
  let fullPath = '/Users/'. user . '/.config/nvim/plugin/'. a:relativePath
  exec 'source ' . fullPath
endfunction

call Source('./telescope.vim')
call Source('./camelCaseMotion.vim')
call Source('./tComment.vim')
