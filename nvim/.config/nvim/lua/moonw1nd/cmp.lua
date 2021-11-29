local cmp = require("cmp");
local lspkind = require("lspkind")

local function get_kind(kind_item)
    return lspkind.presets.default[kind_item]
end

vim.opt.completeopt = "menuone,noselect"
-- vim.opt.dictionary:append("/Users/moonw1nd/dotfiles/livecoding_dict")

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
                    dictionary = "﬜",
                    path = "ﱮ",
                    buffer = "﬘",
                    zsh = "",
                    ultisnips = "",
                    spell = "暈",
                    calc = "",
                    emoji = "ﮚ",
                })[entry.source.name]

                return vim_item
            end,
        },
        documentation = {
            border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
        },
        mapping = {
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-x><C-o>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
            ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), {"i", "c"}),
            ["<CR>"] = cmp.mapping.confirm({select = true}),
            ["<C-l>"] = cmp.mapping(
                cmp.mapping.confirm({select = false}), {"i", "c"}
            ),
            ["<C-j>"] = cmp.mapping(
                cmp.mapping.select_next_item(
                    {behavior = cmp.SelectBehavior.Select}
                ), {"i", "c"}
            ),
            ["<C-k>"] = cmp.mapping(
                cmp.mapping.select_prev_item(
                    {behavior = cmp.SelectBehavior.Select}
                ), {"i", "c"}
            ),
        },
        sources = cmp.config.sources(
            {
                {name = "nvim_lsp"},
                {name = "calc"},
                {name = "treesitter"},
                {name = "emoji"},
                {name = "ultisnips"},
                {name = "dictionary", keyword_length = 2},
                {
                    name = "buffer",
                    options = {
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
cmp.setup.cmdline(
    "/", {
        sources = {{name = "buffer"}, {name = "treesitter"}},
        completion = {autocomplete = false},
    }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
    ":", {
        sources = {{name = "path"}, {name = "cmdline"}, {name = "treesitter"}},
        completion = {autocomplete = false},
    }
)
