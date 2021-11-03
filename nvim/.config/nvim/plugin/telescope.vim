nnoremap <leader>rr :lua require('moonw1nd.telescope').refactors()<CR>
vnoremap <leader>rr :lua require('moonw1nd.telescope').refactors()<CR>

nnoremap <C-g> :lua require('moonw1nd.telescope').rg()<CR>
nnoremap <Leader>fp :lua require('moonw1nd.telescope').project_files()<CR>
nnoremap <leader>fs :lua require('telescope.builtin').git_status()<CR>
nnoremap <leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>fh :lua require('telescope.builtin').help_tags()<CR>

nnoremap <Leader>ra :lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_dropdown({}))<CR>

nnoremap ghP :lua require('moonw1nd.telescope').pull_request()<CR>
nnoremap ghp :lua require('moonw1nd.telescope').my_pull_request()<CR>
nnoremap ghr :lua require('moonw1nd.telescope').reviews_pull_request()<CR>
nnoremap <leader>fd :lua require('moonw1nd.telescope').search_wiki()<CR>
nnoremap <leader>vrc :lua require('moonw1nd.telescope').search_dotfiles()<CR>
