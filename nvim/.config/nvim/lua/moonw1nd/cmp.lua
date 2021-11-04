local cmp = require("cmp");
local lspkind = require("lspkind")

local function get_kind(kind_item)
    return lspkind.presets.default[kind_item]
end

vim.opt.completeopt = "menuone,noselect"

cmp.setup(
    {
        snippet = {
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = string.format(
                                    "%s %s", get_kind(vim_item.kind),
                                    vim_item.kind
                                )
                vim_item.menu = ({
                    nvim_lsp = "ﲳ",
                    treesitter = "",
                    path = "ﱮ",
                    buffer = "﬘",
                    zsh = "",
                    ultisnips = "",
                    spell = "暈",
                    -- luasnip = "[Snp]",
                    -- path = "[Pth]",
                    calc = "",
                    emoji = "ﮚ",
                })[entry.source.name]

                return vim_item
            end,
        },
        experimental = {ghost_text = true},
        documentation = {
            border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
        },
        mapping = {
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-x><C-o>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({select = true}),
            ["<Tab>"] = {
                i = cmp.mapping.confirm({select = true}),
                c = cmp.mapping.confirm({select = true}),
            },
            ["<C-j>"] = {
                i = cmp.mapping.select_next_item(
                    {behavior = cmp.SelectBehavior.Select}
                ),
                c = cmp.mapping.select_next_item(
                    {behavior = cmp.SelectBehavior.Select}
                ),
            },
            ["<C-k>"] = {
                i = cmp.mapping.select_prev_item(
                    {behavior = cmp.SelectBehavior.Select}
                ),
                c = cmp.mapping.select_prev_item(
                    {behavior = cmp.SelectBehavior.Select}
                ),
            },
        },
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "calc"},
                {name = "treesitter"},
                {name = "emoji"},
                {name = "ultisnips"},
                {
                    name = "buffer",
                    opts = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
                {name = "path"},
            }
        ),
    }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {sources = {{name = "buffer"}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    ":", {sources = cmp.config.sources({{name = "path"}}, {{name = "cmdline"}})}
)
