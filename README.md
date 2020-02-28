# Setup environment

## Terminal

### Alacritty

[github](https://github.com/alacritty/alacritty)

```shell
brew cask install alacritty
```

### pure theme

[github](https://github.com/sindresorhus/pure)

```shell
npm install --global pure-prompt
```

## CL

### ripgrep

[github](https://github.com/BurntSushi/ripgrep)

```shell
brew install ripgrep
```

### fzf

[github](https://github.com/junegunn/fzf)

```shell
brew install fzf

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install

```
### silver search (ag)

[github](https://github.com/ggreer/the_silver_searcher)

```shell
brew install the_silver_searcher
```

### bat 

[github](https://github.com/sharkdp/bat)

```shell
brew install bat
```

### exa

[github](https://github.com/ogham/exa)

```shell
brew install exa
```

### Tmux plugin manager

[github](https://github.com/tmux-plugins/tpm)

```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### xkbswitch

[github](https://github.com/myshov/xkbswitch-macosx/blob/master/README.md)

For installation put executable file from bin directory in any directory in your $PATH
variable. For example you can put it into  `/usr/local/bin` with this command (if source
files of utility in your `Download` directory):

```shell
$ cp ~/Download/xkbswitch-macosx/bin/xkbswitch /usr/local/bin
```

### fd

```shell
brew install fd
```

### tmuxinator

[github](https://github.com/tmuxinator/tmuxinator)

```
brew install tmuxinator
```

## Languages

### python && python3

We need neovim python providers

```shell
pip3 install pynvim

pip install pynvim
```

## zsh plugins

### zsh-autosuggestions

[github](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)


### zsh-highlighting

[github](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

### Homebrew Command Not Found

[github](https://github.com/Homebrew/homebrew-command-not-found)

### web-search

[github](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search)

### zsh-completions

[github](https://github.com/zsh-users/zsh-completions)
