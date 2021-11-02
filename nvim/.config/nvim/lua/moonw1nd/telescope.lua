local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.finders")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local actions = require("telescope.actions")

require("telescope").setup(
    {
        defaults = {
            preview = {timeout = 500, msg_bg_fillchar = ""},
            layout_strategy = "bottom_pane",
            layout_config = {
                bottom_pane = {height = 0.9, prompt_position = "bottom"},
            },
            file_sorter = sorters.get_fzy_sorter,
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

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files(
        {
            prompt_title = "< Dotfiles >",
            file_ignore_patterns = {".git", "node_modules"},
            cwd = vim.env.DOTFILES,
            hidden = true,
        }
    )
end

M.git_status_file = function()

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

return M
