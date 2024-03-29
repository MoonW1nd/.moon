local lspConfig = require("lspconfig")
local lspSetting = require("moonw1nd.lsp.settings");

-- Config for Lua
local userName = vim.fn.expand("$USER")

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
    sumneko_root_path = "/Users/" .. userName ..
                            "/.config/nvim/lua-language-server"
    sumneko_binary = "/Users/" .. userName ..
                         "/.config/nvim/lua-language-server/bin/lua-language-server"
elseif vim.fn.has("unix") == 1 then
    sumneko_root_path = "/home/" .. userName ..
                            "/.config/nvim/lua-language-server"
    sumneko_binary = "/home/" .. userName ..
                         "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
else
    print("Unsupported system for sumneko")
end

-- this is the ONLY correct way to setup your path
local runtime_path = vim.split(package.path, ";")

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspConfig.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    capabilities = lspSetting.capabilities,
    oflags = {debounce_text_changes = 150},
    on_attach = lspSetting.set_keymap,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {"vim"},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    -- path to nvim plugins
                    [vim.fn.expand("$HOME/.config/nvim/plugged/")] = true,
                    -- path to my nvim plugins in arc
                    [vim.fn.expand("$HOME/Documents/develop/lua/")] = true,
                    -- luarocks dependency
                    [vim.fn.expand("/opt/homebrew/lib/luarocks/rocks-5.4/")] = true,
                    -- [vim.fn.expand("$HOME/Documents/develop/work/arcadia/junk/moonw1nd/lua/")] = true,
                },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false},
        },
    },
}

