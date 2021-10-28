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
}

-- force_reinstall_parsers();
