nnoremap <leader>rr :lua require('moonw1nd.telescope').refactors()<CR>
vnoremap <leader>rr :lua require('moonw1nd.telescope').refactors()<CR>

nnoremap <C-g> :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <Leader>ff :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>fp :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>fw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>vrc :lua require('moonw1nd.telescope').search_dotfiles()<CR>
nnoremap <leader>fg :lua require('moonw1nd.telescope').git_branches()<CR>
" nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
" nnoremap <leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
nnoremap <leader>td :lua require('moonw1nd.telescope').dev()<CR>