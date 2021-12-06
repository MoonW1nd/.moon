local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.finders")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local telescope_gh_actions = require("telescope._extensions.gh_actions")

require("telescope").setup(
    {
        defaults = {
            preview = {timeout = 500, msg_bg_fillchar = ""},
            layout_strategy = "bottom_pane",
            layout_config = {
                bottom_pane = {height = 0.9, prompt_position = "bottom"},
            },
            file_sorter = sorters.get_fzy_sorter,
            file_ignore_patterns = {".git", "node_modules", "package-lock.json"},
            prompt_prefix = " λ ",
            color_devicons = true,

            file_previewer = previewers.vim_buffer_cat.new,
            grep_previewer = previewers.vim_buffer_vimgrep.new,
            qflist_previewer = previewers.vim_buffer_qflist.new,

            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<esc>"] = actions.close,
                    ["<C-x>"] = false,
                    ["<C-q>"] = actions.send_selected_to_qflist +
                        actions.open_qflist,
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = false,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    }
)

require("telescope").load_extension("git_worktree")
require("telescope").load_extension("fzf")
require("telescope").load_extension("gh")

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files(
        {prompt_title = "< Dotfiles >", cwd = vim.env.DOTFILES, hidden = true}
    )
end

M.rg = function()
    require("telescope.builtin").grep_string {
        path_display = {"truncate"},
        search = vim.fn.input("Rg  "),
        only_sort_text = true,
        full = true,
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
        },
    }
end

-- Work action pluggin {{{
local COMAND_ACTION_DESCRIPTION = {
    ["REBILD_SERVER"] = "Rebuild server",
    ["RESTART_SERVER"] = "Restart server",
    ["RESTART_WEBPACK"] = "Restart webpack",
    ["MAKE_TS"] = "Run check typescript",
}

local execute_working_command = function(prompt_bufnr)
    local selection = action_state.get_selected_entry()

    actions.close(prompt_bufnr)

    local tmp_table = vim.split(selection.value, "\t");

    if vim.tbl_isempty(tmp_table) then
        return
    end

    local command_action = tmp_table[1]

    if command_action == COMAND_ACTION_DESCRIPTION.REBILD_SERVER then
        vim.api.nvim_command("RebildServer")
    elseif command_action == COMAND_ACTION_DESCRIPTION.RESTART_SERVER then
        vim.api.nvim_command("ReloadServer")
    elseif command_action == COMAND_ACTION_DESCRIPTION.RESTART_WEBPACK then
        vim.api.nvim_command("ReloadWebpack")
    elseif command_action == COMAND_ACTION_DESCRIPTION.MAKE_TS then
        vim.api.nvim_command("MakeTs")
    end
end

M.work_scripts = function()
    local command_actions = {
        COMAND_ACTION_DESCRIPTION.RESTART_SERVER,
        COMAND_ACTION_DESCRIPTION.RESTART_WEBPACK,
        COMAND_ACTION_DESCRIPTION.REBILD_SERVER,
        COMAND_ACTION_DESCRIPTION.MAKE_TS,
    }

    local dropdownTheme = require("telescope.themes").get_dropdown();

    local opts = {
        prompt_title = "Actions",
        finder = finders.new_table(command_actions),
        sorter = conf.generic_sorter(),
        attach_mappings = function(_, _)
            actions.select_default:replace(execute_working_command)
            return true
        end,
    }

    local picker = pickers.new(dropdownTheme, opts)
    picker:find()
end
-- }}}

M.project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require"telescope.builtin".git_files, opts)

    if not ok then
        require"telescope.builtin".find_files(opts)
    end
end

-- Переписаный модуль для preview github так как lua os.execute не работал
M.gh_web_view = function(type)
    return function(prompt_bufnr)
        local selection = action_state.get_selected_entry(prompt_bufnr)
        local tmp_table = vim.split(selection.value, "\t");

        if vim.tbl_isempty(tmp_table) then
            return
        end

        vim.api.nvim_command(
            "silent !gh " .. type .. " view --web " .. tmp_table[1]
        )
        actions.close(prompt_bufnr)
    end
end

-- Mapping for telescope github
local gh_pr_attach_mappings = function(_, map)
    map("i", "<c-e>", telescope_gh_actions.gh_pr_v_toggle)
    -- use mapping <c-m> crash mappings
    map("i", "<c-c>", telescope_gh_actions.gh_pr_merge)
    map("i", "<c-g>", telescope_gh_actions.gh_pr_checkout)
    actions.select_default:replace(M.gh_web_view("pr"))
    return true
end

M.pull_request = function()
    require("telescope").extensions.gh.pull_request(
        {attach_mappings = gh_pr_attach_mappings}
    )
end

M.my_pull_request = function()
    require("telescope").extensions.gh.pull_request(
        {author = "@me", attach_mappings = gh_pr_attach_mappings}
    )
end

M.reviews_pull_request = function()
    require("telescope").extensions.gh.pull_request(
        {
            search = "review-requested:@me",
            attach_mappings = function(_, map)
                map("i", "<c-e>", telescope_gh_actions.gh_pr_v_toggle)
                map("i", "<c-g>", telescope_gh_actions.gh_pr_checkout)
                actions.select_default:replace(M.gh_web_view("pr"))
                return true
            end,
        }
    )
end

M.search_wiki = function()
    require("telescope.builtin").find_files(
        {
            prompt_title = "< Wiki >",
            file_ignore_patterns = {".git"},
            cwd = vim.env.WIKI_PATH,
            hidden = true,
        }
    )
end

local function refactor(prompt_bufnr)
    local content = action_state.get_selected_entry(prompt_bufnr)
    require("telescope.actions").close(prompt_bufnr)
    require("refactoring").refactor(content.value)
end

M.refactors = function()
    local opts = require("telescope.themes").get_cursor()

    pickers.new(
        opts, {
            prompt_title = "refactors",
            finder = finders.new_table(
                {results = require("refactoring").get_refactors()}
            ),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(_, map)
                map("i", "<CR>", refactor)
                map("n", "<CR>", refactor)
                return true
            end,
        }
    ):find()
end

M.git_branches = function()
    require("telescope.builtin").git_branches(
        {
            attach_mappings = function(_, map)
                map("i", "<c-d>", actions.git_delete_branch)
                map("n", "<c-d>", actions.git_delete_branch)
                return true
            end,
        }
    )
end

M.my_fd = function(opts)
    opts = opts or {}
    opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    require"telescope.builtin".find_files(opts)
end

return M
