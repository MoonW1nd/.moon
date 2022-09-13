#!/bin/bash

if ! hash brew 2>/dev/null
then
    echo 'brew is not install or is not in $PATH'
    exit 1
fi

# install useful stuff with brew

brew update

brew upgrade

brew install autojump # smart cd
brew install bat # modern cat
brew install bottom # top/htop alternative
brew install dust # like du but more intuitive.
brew install exa # modern ls
brew install fd # modern find
brew install freetype # library to render fonts
brew install fzf # cli fuzzy finder written in Go
$(brew --prefix)/opt/fzf/install # install useful key bindings
brew install gh # github cli
brew install git # updated version
brew install git-delta # improved diff highlight
brew install git-lfs # github large file storage
brew install htop # top but better
brew install jpeg # image manipulation lib
brew install jq # cli for working with json
brew install neovim # vim but better
brew install node # nodejs & npm
brew install yarn # analog npm
brew install pnpm # analog npm
brew install openssl
brew install procs # ps in rust
brew install python
brew install python3
brew install rbenv # ruby version manager
brew install ripgrep
brew install tmux # terminal multiplexer
brew install tree # cli to display directories as trees
brew install ccat # cat with ansi
brew install vim # get the recent vim version
brew install vifm # get vim like file manager
brew install wget # cli to download stuff
brew install the_silver_searcher
brew install zsh # bash but better
brew install coreutils # useful Linux utils in mac
brew install starship # best prompt
brew install neofetch # infor about system
brew install zk # create notes from tamplate

# install nvm
brew install nvm
mkdir ~/.nvm

# cask apps
brew install alacritty # terminal
brew install alfred # spotlight but useful
# brew install docker # docker desktop app
# brew install firefox
# brew install gimp
# brew install karabiner-elements # advanced key mapping
# brew install keycastr # useful for demos
# brew install loopback # virtual devises to pass audio to obs
# brew install monitorcontrol # control external monitors brightness from keyboard
# brew install obs # streaming & screen recording
# brew install telegram # chats
brew install vlc # media player
brew install --cask yandex-music-unofficial
brew install --cask keycastr # show key pressed on window



# fonts
# TODO check setup fonts
# brew tap homebrew/cask-fonts
# brew install --cask font-fira-code


# install o-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install go version manager
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

# install skhd
brew install koekeishiya/formulae/skhd
brew services start skhd

# install amethyst
brew install --cask amethyst
