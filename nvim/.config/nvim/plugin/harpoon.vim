nnoremap <leader>oh :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>oc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
nnoremap <leader>ot :lua require("harpoon.term").gotoTerminal(1)<CR> 

nnoremap <leader>ah :lua require("harpoon.mark").add_file()<CR>
nnoremap ]h :lua require("harpoon.ui").nav_next()<CR>
nnoremap [h :lua require("harpoon.ui").nav_prev()<CR>
nnoremap <leader>cr :lua require("harpoon.term").sendCommand(2, vim.api.input())<CR>

