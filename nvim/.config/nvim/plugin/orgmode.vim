" noremap <localleader>tc :Neorg gtd capture<CR>
" noremap <localleader>tt :silent lua require("moonw1nd.neorg").today_tasks()<CR>
" " noremap <localleader>tt :Telekasten<CR>
" noremap <localleader>tv :Neorg gtd views<CR>
" noremap <localleader>tm :Neorg inject-metadata<CR>
nnoremap <leader>zp :lua require('telekasten').find_notes()<CR>
nnoremap <leader>zd :lua require('telekasten').find_daily_notes()<CR>
nnoremap <leader>zg :lua require('telekasten').search_notes()<CR>
nnoremap <leader>zT :lua require('telekasten').goto_today()<CR>
nnoremap <leader>zW :lua require('telekasten').goto_thisweek()<CR>
nnoremap <leader>zw :lua require('telekasten').find_weekly_notes()<CR>
nnoremap <leader>zn :lua require('telekasten').new_note()<CR>
nnoremap <leader>zN :lua require('telekasten').new_templated_note()<CR>
nnoremap <leader>zy :lua require('telekasten').yank_notelink()<CR>
nnoremap <leader>zc :lua require('telekasten').show_calendar()<CR>
nnoremap <leader>zC :CalendarT<CR>
" nnoremap <leader>zi :lua require('telekasten').paste_img_and_link()<CR>
" use in markdown flow
" nnoremap <leader>zt :lua require('telekasten').toggle_todo()<CR>
nnoremap <leader>zb :lua require('telekasten').show_backlinks()<CR>
nnoremap <leader>zF :lua require('telekasten').find_friends()<CR>
" nnoremap <leader>zI :lua require('telekasten').insert_img_link({ i=true })<CR>
" nnoremap <leader>zp :lua require('telekasten').preview_img()<CR>
nnoremap <leader>zm :lua require('telekasten').browse_media()<CR>
nnoremap <leader>za :lua require('telekasten').show_tags()<CR>
nnoremap <leader># :lua require('telekasten').show_tags()<CR>
nnoremap <leader>zr :lua require('telekasten').rename_note()<CR>
nnoremap <leader>zi :lua require('telekasten').insert_link()<CR>

" on hesitation, bring up the panel
nnoremap <leader>zz :lua require('telekasten').panel()<CR>


" inoremap <leader>[ <cmd>:lua require('telekasten').insert_link({ i=true })<CR>
" inoremap <leader>zt <cmd>:lua require('telekasten').toggle_todo({ i=true })<CR>
" inoremap <leader># <cmd>lua require('telekasten').show_tags({i = true})<cr>

