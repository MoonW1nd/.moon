# Vim Tricks

- [Keybindings](#keybindings)
- [Work with register](#work-with-register)
- [How do I insert the current visual selection phrase into the command-line?](#insert-visual-selection)
- [Replace last search text](#replace-last-search)

<a id="install-vim-plugins-manually"></a>
## [Install Vim Plugins Munually](https://opensource.com/article/20/2/how-install-vim-plugins)

```bash
mkdir -p ~/.vim/pack/vendor/start
cp plugin/path ~/.vim/pack/vendor/start

```

<a id="keybindings"></a>
## Keybindings

**Insert mode delete movement**<br/>
```vim
<C-h> " delete back one character (backspace)
<C-w> " delete back one word
<C-u> " delete back to start of line
<C-k> " delete forward to end of line
```

**Line substitution**<br/>
```vim
<C-w><C-l>
```


<a id="work-with-register"></a>
## Work with registers

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

<a id="insert-visual-selection"></a>
## How do I insert the current visual selection phrase into the command-line?

You can use the contents of any register on the ex or search command-lines with `<C-R>` followed by the register's name.
By yanking your visual selection, it is put into the `0` register, so `<C-R>0` will add your yanked selection to the current command-line.

> Info by [StackOverflow](https://stackoverflow.com/questions/3619809/how-do-i-insert-the-current-visual-selection-phrase-into-the-command-line)

<a id="replace-last-search"></a>
## Replace last search text

More about search and replace: [https://vim.fandom.com/wiki/Search_and_replace](https://vim.fandom.com/wiki/Search_and_replace)<br/>
```vim
%s//replaceText/g
```

<a id="search-and-command-history"></a>
## Show search and command history

```vim
q: " command history
q? " search backward history
q/ " search forward history

<C-f> " command history in ex command
```

[ripgrep regex syntax](https://docs.rs/regex/1.5.4/regex/#syntax)

## How do I set options specific to the current buffer?

You can set Vim options which are specific to a buffer using the "setlocal" command. For example,

```
:setlocal textwidth=70
```

This will set the 'textwidth' option to 70 only for the current buffer. All other buffers will have the default or the previous 'textwidth' value.

## How do I define mappings specific to the current buffer?

You can define mappings specific to the current buffer by using the keyword "<buffer>" in the map command. For example,

```
:map <buffer> ,w /[.,;]<CR>
```

## How to replace a character by a newline in Vim?

Use `\r` instead of `\n`.

> Info by [StackOverflow](https://stackoverflow.com/questions/71323/how-to-replace-a-character-by-a-newline-in-vim/71334)
