local cmp = require("cmp")
local lspConfig = require("lspconfig")
local lspkind = require("lspkind")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {noremap = true, silent = true}

    vim.opt.completeopt = "menu,menuone,noselect"

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap(
        "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts
    )
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap(
    --     "n", "<space>wl",
    --     "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    --     opts
    -- )
    buf_set_keymap(
        "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts
    )
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap(
        "n", "<space>e",
        "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts
    )
    buf_set_keymap(
        "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts
    )
    buf_set_keymap(
        "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts
    )
    buf_set_keymap(
        "n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts
    )
    -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

cmp.setup(
    {
        snippet = {
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        formatting = {
            format = lspkind.cmp_format({with_text = false, maxwidth = 50}),
        },
        mapping = {
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm({select = true}),
            ["<C-j>"] = cmp.mapping.select_next_item(
                {behavior = cmp.SelectBehavior.Select}
            ),
            ["<C-k>"] = cmp.mapping.select_prev_item(
                {behavior = cmp.SelectBehavior.Select}
            ),
        },
        sources = cmp.config.sources(
            {{name = "nvim_lsp"}, {name = "ultisnips"}},
            {{name = "buffer"}, {name = "path"}, {name = "cmdline"}}
        ),
    }
)

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(
                         vim.lsp.protocol.make_client_capabilities()
                     )

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"pyright", "bashls", "tsserver", "eslint", "cssls", "html"}

local settings = {
    cssls = {
        css = {validate = false},
        less = {validate = false},
        scss = {validate = false},
    },
}

for _, lsp in ipairs(servers) do
    local lspSettings = settings[lsp] and settings[lsp] or nil

    lspConfig[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {debounce_text_changes = 150},
        settings = lspSettings,
    }
end

-- Config for Lua
local userName = vim.fn.expand("$USER")

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
    sumneko_root_path = "/Users/" .. userName ..
                            "/.config/nvim/lua-language-server"
    sumneko_binary = "/Users/" .. userName ..
                         "/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
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
    capabilities = capabilities,
    oflags = {debounce_text_changes = 150},
    on_attach = on_attach,
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
                },
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false},
        },
    },
}

lspConfig.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {"lua"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {
                    lintCommand = "luacheck --globals vim --filename ${INPUT} --formatter plain -",
                    lintStdin = true,
                    lintFormats = {"%f:%l:%c: %m"},
                },
                {
                    -- TODO support config file
                    formatCommand = "lua-format -i --config='/Users/moonw1nd/dotfiles/.lua-format'",
                    formatStdin = true,
                },
            },
        },
    },
}
