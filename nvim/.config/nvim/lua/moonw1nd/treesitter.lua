local used_parsers = {
    "html",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "php",
    "rust",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "yaml",
    "query",
}

-- pass parsers table to turn off certain parsers
-- @example { jsonc = false }
-- luacheck: ignore force_reinstall_parsers
---@diagnostic disable-next-line
local function force_reinstall_parsers(opts)
    opts = opts or {}
    local TSI = require("nvim-treesitter.install")

    -- `install` function is not exported from nvim-treesitter
    -- This is a naughty way to get its reference
    -- This is not a public API and can break at any time
    --
    -- @param lang string Language to reinstall
    -- @return nil
    local force_install_lang = TSI.commands.TSInstall["run!"]

    for _, v in pairs(used_parsers) do
        if opts[v] ~= false then
            force_install_lang(v)
        end
    end
end

require"nvim-treesitter.configs".setup {
    highlight = {enable = true, additional_vim_regex_highlighting = false},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    matchup = {enable = true}, -- find plugin
    autopairs = {enable = true}, -- find plugin
    rainbow = { -- find plugin
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters
        max_file_lines = 1000,
    },
    context_commentstring = {enable = true, enable_autocmd = false},
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@call.outer",
            },
            goto_next_end = {["]M"] = "@function.outer", ["]["] = "@call.outer"},
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@call.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@call.outer",
            },
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@call.outer",
                ["ic"] = "@call.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {[",a"] = "@parameter.inner"},
            swap_previous = {[",A"] = "@parameter.inner"},
        },
    },
}

-- force_reinstall_parsers();
