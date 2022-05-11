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
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    }
)

require("telescope").load_extension("git_worktree")
require("telescope").load_extension("fzf")
require("telescope").load_extension("gh")
require("telescope").load_extension("harpoon")
require("telescope").load_extension("arc")


local M = {}

M.work_scripts = require("moonw1nd.telescope.work_scripts")
M.search_dotfiles = require("moonw1nd.telescope.search_dotfiles")
M.rg = require("moonw1nd.telescope.rg")
M.vcs = require("moonw1nd.telescope.vcs")

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
