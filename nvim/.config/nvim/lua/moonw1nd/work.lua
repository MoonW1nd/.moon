local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")

local M = {}

local addToSet = function(set, key)
    set[key] = true
end

-- local removeFromSet = function(set, key)
--     set[key] = nil
-- end

local setContains = function(set, key)
    return set[key] ~= nil
end

local directoryExists = function(path)
    local f = io.popen("cd " .. path)
    local ff = f:read("*all")

    if (ff:find("ItemNotFoundException")) then
        return false
    else
        return true
    end
end

M.dump = function(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = "\"" .. k .. "\""
            end
            s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

local execute_working_command = function(packet, platform, fileName)
    return function(prompt_bufnr)
        local selection = action_state.get_selected_entry()

        actions.close(prompt_bufnr)

        local tmp_table = vim.split(selection.value, "\t");

        if vim.tbl_isempty(tmp_table) then
            return
        end

        local command_action = tmp_table[1]

        local path = "$PWD/src/" .. packet .. "/" .. platform .. "/" ..
                         command_action .. "/"

        local _, targetsSet = M.execute("ls " .. path)

        if (setContains(targetsSet, fileName)) then
            if (directoryExists(path .. fileName)) then
                local _, filesSet = M.execute("ls " .. path .. fileName .. "/")

                if (setContains(filesSet, "index.ts")) then
                    vim.api
                        .nvim_command("e " .. path .. fileName .. "/index.ts")
                elseif (setContains(filesSet, "index.js")) then
                    print("e " .. path .. fileName .. "/index.js")
                    vim.api
                        .nvim_command("e " .. path .. fileName .. "/index.js")
                end
            end
        elseif (setContains(targetsSet, fileName .. ".js")) then
            vim.api.nvim_command("e " .. path .. fileName .. ".js")
        elseif (setContains(targetsSet, fileName .. ".ts")) then
            vim.api.nvim_command("e " .. path .. fileName .. ".ts")
        else
            vim.api.nvim_command("Dirvish " .. path)
        end

    end
end

function M.execute(command)
    local lines = {}
    local linesSet = {}
    local file = io.popen(command)
    for line in file:lines() do
        table.insert(lines, line)
        addToSet(linesSet, line)
    end
    file:close()
    return lines, linesSet
end

function M.home_module()
    local path = vim.fn.expand("%")
    local fileName = string.match(vim.fn.expand("%:r"), ".*/([^/]*)$")

    if (fileName == "index") then
        local folderPath = vim.fn.expand("%:p:h")

        fileName = string.match(folderPath, ".*/([^/]*)$")
    end

    local packet, platform = string.match(path, "src/([^/]*)/([^/]*)/.*")

    local targets =
        M.execute("ls $PWD/src/" .. packet .. "/" .. platform .. "/")

    local opts = {
        prompt_title = packet,
        finder = finders.new_table(targets),
        sorter = conf.generic_sorter(),
        attach_mappings = function(_, _)
            actions.select_default:replace(
                execute_working_command(
                    packet, platform, fileName
                )
            )
            return true
        end,
    }

    local dropdownTheme = require("telescope.themes").get_dropdown();

    local picker = pickers.new(dropdownTheme, opts)

    picker:find()
end

return M
