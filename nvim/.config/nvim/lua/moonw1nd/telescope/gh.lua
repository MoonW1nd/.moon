local telescope_gh_actions = require("telescope._extensions.gh_actions")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

-- Переписаный модуль для preview github так как lua os.execute не работал
local gh_web_view = function(type)
    return function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
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
    actions.select_default:replace(gh_web_view("pr"))
    map("i", "<c-e>", telescope_gh_actions.gh_pr_v_toggle)
    -- use mapping <c-m> crash mappings
    map("i", "<c-c>", telescope_gh_actions.gh_pr_merge)
    map("i", "<c-g>", telescope_gh_actions.gh_pr_checkout)

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
                actions.select_default:replace(gh_web_view("pr"))
                return true
            end,
        }
    )
end

return M
