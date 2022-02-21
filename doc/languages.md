# Programming language

Programming languages installation & setup guide.

- [Python](#python)
- [Lua](#lua)
- [Vim LSP](#vim-lsp)

## Python

We need neovim python providers

```shell
pip3 install pynvim

pip install pynvim
```

## Lua

[Setup Neovim for Lua Development](https://www.chrisatmachine.com/Neovim/28-neovim-lua-development/)

**Install ninja**

```shell
# Linux
sudo apt install ninja-build

# MacOS
brew install ninja
```

**Clone [Lua Language Server](https://github.com/sumneko/lua-language-server) Repo**

```shell
cd ~/.config/nvim
git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive
```

**Build language Lua Server**

```shell
cd ./3rd/luamake

# for MacOs
ninja -f ninja/macos.ninja

# for Linux
ninja -f ninja/linux.ninja

cd ../..
./3rd/luamake/luamake rebuild
```

**Install package manager ([Luarocks](https://github.com/luarocks/luarocks))**

```shell
brew install luarocks
```

**Install Lua formatter ([luaformatter](https://github.com/Koihik/LuaFormatter))**

```shell
luarocks install --server=https://luarocks.org/dev luaformatter
```

**Install Lua linting ([luacheck](https://github.com/mpeterv/luacheck))**
```shell
luarocks install luacheck
```

**Install [efm-language-server](https://github.com/mattn/efm-langserver)**

```shell
# Linux
go get github.com/mattn/efm-langserver

# MacOS
brew install efm-langserver
```

## Vim LSP

### cssmodules-language-server

```shell
npm install --global cssmodules-language-server
```
