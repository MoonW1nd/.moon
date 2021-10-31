# Vim Tricks

- [How do I insert the current visual selection phrase into the command-line?](#insert-visual-selection)
- [Replace last search text](#replace-last-search)

<a id="insert-visual-selection" />

### How do I insert the current visual selection phrase into the command-line?

You can use the contents of any register on the ex or search command-lines with `<C-R>` followed by the register's name.
By yanking your visual selection, it is put into the `0` register, so `<C-R>0` will add your yanked selection to the current command-line.

> Info by [StackOverflow](https://stackoverflow.com/questions/3619809/how-do-i-insert-the-current-visual-selection-phrase-into-the-command-line)

**Reginsters info**</br>
[How do I use vim registers?](https://stackoverflow.com/questions/1497958/how-do-i-use-vim-registers)<br/>
`:reg` - show current register contents<br/>

**Some usefull registers**<br/>
`"*` or `"+` - the contents of the system clipboard<br/>
`"/` - last search command<br/>
`":` - last command-line command.<br/>

**The expression and the search registers**

The expression register ("=) is used to deal with results of expressions.
This is easier to understand with an example. If, in insert mode, you type `Ctrl-r =`, 
you will see a “=” sign in the command line. Then if you type `2+2 <enter>`, 
4 will be printed. This can be used to execute all sort of expressions, even calling external commands. 
To give another example, if you type `Ctrl-r =` and then, in the command line, `system('ls') <enter>`, the output of the ls command will be pasted in your buffer.

<a id="replace-last-search" />

### Replace last search text

More about search and replace: [https://vim.fandom.com/wiki/Search_and_replace](https://vim.fandom.com/wiki/Search_and_replace)<br/>
```
%s//replaceText/g
```

