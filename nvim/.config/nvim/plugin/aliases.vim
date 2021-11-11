" Command aliases settings

" creating aliace command function
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" Aliases
call SetupCommandAlias("ut","UndotreeToggle")
call SetupCommandAlias("gs","vertical Git<CR>")
call SetupCommandAlias("td",'Todo')
call SetupCommandAlias("rs",'AffRSync')
call SetupCommandAlias("ot",'OpenCurrentTicket')
call SetupCommandAlias("ob",'OpenCurrentBranch')
call SetupCommandAlias("gob",'GhOpenCurrentBranch')
call SetupCommandAlias("gcn","silent Git commit -n<CR>")
call SetupCommandAlias("gpn","Git push --no-verify<CR>")
call SetupCommandAlias("gmt","G mergetool")
call SetupCommandAlias("gdt","G difftool")
call SetupCommandAlias("gr","Rg")
call SetupCommandAlias("gra","Rga")
call SetupCommandAlias("dab","Dab")
call SetupCommandAlias("cam","call ClearAllMarks()")
