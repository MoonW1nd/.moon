nnoremap <leader>rr :lua require('moonw1nd.telescope').refactors()<CR>
vnoremap <leader>rr :lua require('moonw1nd.telescope').refactors()<CR>

" nnoremap <C-g> :lua require('moonw1nd.telescope').rg()<CR>
nnoremap <Leader>fp :lua require('moonw1nd.telescope').vcs.project_files()<CR>
nnoremap <Leader>f- :Telescope<CR>
nnoremap <leader>fs :lua require("moonw1nd.telescope").vcs.status()<CR>
nnoremap <leader>fb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>fh :Telescope harpoon marks<CR>
nnoremap <leader>fl :lua require("telescope").extensions.live_grep_raw.live_grep_raw()<CR>
nnoremap <leader>fa :lua require("moonw1nd.telescope").work_scripts()<CR>
nnoremap <leader>fd :lua require('moonw1nd.telescope').search_wiki()<CR>
nnoremap <leader>fvc :lua require("moonw1nd.telescope").vcs.commits()<CR>
nnoremap <leader>fvb :lua require("moonw1nd.telescope").vcs.branches()<CR>
nnoremap <leader>fvh :lua require("moonw1nd.telescope").vcs.stash()<CR>

nnoremap gd :silent Telescope lsp_definitions<CR>
nnoremap gr :silent Telescope lsp_references<CR>
nnoremap gi :silent Telescope lsp_implementations<CR>

nnoremap <Leader>ra :lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_dropdown({}))<CR>

" Need rewrite
nnoremap <localleader>oP :lua require('moonw1nd.telescope').vcs.pull_request()<CR>
nnoremap <localleader>op :lua require('moonw1nd.telescope').vcs.my_pull_request()<CR>
nnoremap <localleader>or :lua require('moonw1nd.telescope').vcs.reviews_pull_request()<CR>
nnoremap <leader>vrc :lua require('moonw1nd.telescope').search_dotfiles()<CR>
