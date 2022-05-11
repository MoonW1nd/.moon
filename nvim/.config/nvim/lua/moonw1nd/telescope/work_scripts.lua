local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local COMAND_ACTION_DESCRIPTION = {
    ["SYNC_AND_RESTART_SERVER"] = "Sync and restart server",
    ["RESTART_SERVER"] = "Restart server",
    ["REBILD_SERVER"] = "Rebuild server",
    ["RESTART_WEBPACK"] = "Restart webpack",
    ["MAKE_TS"] = "Run check types TS [MakeTs]",
    ["MAKE_ESLINT"] = "Run check code style [MakeEslint]",
    ["MAKE_ESLINT_FILE"] = "Run check code style [MakeEslintFile]",
    ["STANDUP"] = "Open zoom standup [Affiliate]",
    ["TECH_MEETING"] = "Open zoom tech meeting [Affiliate]",
}

local command_actions = {
    COMAND_ACTION_DESCRIPTION.RESTART_SERVER,
    COMAND_ACTION_DESCRIPTION.SYNC_AND_RESTART_SERVER,
    COMAND_ACTION_DESCRIPTION.RESTART_WEBPACK,
    COMAND_ACTION_DESCRIPTION.REBILD_SERVER,
    COMAND_ACTION_DESCRIPTION.MAKE_TS,
    COMAND_ACTION_DESCRIPTION.MAKE_ESLINT,
    COMAND_ACTION_DESCRIPTION.MAKE_ESLINT_FILE,
    COMAND_ACTION_DESCRIPTION.STANDUP,
    COMAND_ACTION_DESCRIPTION.TECH_MEETING,
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
    elseif command_action == COMAND_ACTION_DESCRIPTION.SYNC_AND_RESTART_SERVER then
        vim.api.nvim_command("SyncAndReloadServer")
    elseif command_action == COMAND_ACTION_DESCRIPTION.RESTART_WEBPACK then
        vim.api.nvim_command("ReloadWebpack")
    elseif command_action == COMAND_ACTION_DESCRIPTION.MAKE_TS then
        vim.api.nvim_command("MakeTs")
    elseif command_action == COMAND_ACTION_DESCRIPTION.MAKE_ESLINT then
        vim.api.nvim_command("MakeEslint")
    elseif command_action == COMAND_ACTION_DESCRIPTION.MAKE_ESLINT_FILE then
        vim.api.nvim_command("MakeEslintFile")
    elseif command_action == COMAND_ACTION_DESCRIPTION.STANDUP then
        vim.api.nvim_command("Standup")
    elseif command_action == COMAND_ACTION_DESCRIPTION.TECH_MEETING then
        vim.api.nvim_command("TechMeeting")
    end
end

return function()
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
