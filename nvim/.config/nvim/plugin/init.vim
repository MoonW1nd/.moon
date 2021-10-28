" import by realative path
function! Source(relativePath)
  let root = expand('%:p:h')
  let fullPath = root . '/.config/nvim/plugin/'. a:relativePath
  exec 'source ' . fullPath
endfunction

call Source('./telescope.vim')
call Source('./camelCaseMotion.vim')
