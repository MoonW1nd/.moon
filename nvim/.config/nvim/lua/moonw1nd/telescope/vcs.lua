local helpers = require("moonw1nd.telescope.helpers")
local utils = require("telescope.utils")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")

local conf = require("telescope.config").values

local M = {}

local function addToSet(set, key)
    set[key] = true
end

-- local function removeFromSet(set, key)
--     set[key] = nil
-- end

local function setContains(set, key)
    return set[key] ~= nil
end

local function scandir(directory)
    local i, t, popen = 0, {}, io.popen

    local pfile = popen("ls -a \"" .. directory .. "\"")

    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end

    pfile:close()

    return t
end

local arc_files = function(opts)
    helpers.set_opts_cwd(opts)

    if opts.is_bare then
        utils.notify(
            "builtin.arc.files", {
                msg = "This operation must be run in a work tree",
                level = "ERROR",
            }
        )
        return
    end

    -- local show_untracked = utils.get_default(opts.show_untracked, true)
    -- By creating the entry maker after the cwd options,
    -- we ensure the maker uses the cwd options when being created.
    opts.entry_maker = vim.F.if_nil(
                           opts.entry_maker, make_entry.gen_from_file(opts)
                       )

    local root_paths = scandir(opts.cwd)

    local excludeFilesSet = {}

    addToSet(excludeFilesSet, "node_modules")
    addToSet(excludeFilesSet, "app")
    addToSet(excludeFilesSet, "freeze")

    local arc_command = {"arc", "ls-files", "-c", "-o"}

    for key, value in pairs(root_paths) do
        if key > 2 and not setContains(excludeFilesSet, value) then
            table.insert(arc_command, value)
        end
    end

    pickers.new(
        opts, {
            prompt_title = "Arc Files",
            finder = finders.new_oneshot_job(
                vim.tbl_flatten {
                    arc_command,
                    -- show_untracked and "--others" or nil,
                }, opts
            ),
            previewer = conf.file_previewer(opts),
            sorter = conf.file_sorter(opts),
        }
    ):find()
end

M.project_files = function()
    local opts = {} -- define here if you want to define something

    local ok

    if helpers.is_arc_env() then
        ok = pcall(arc_files, opts)
    else
        ok = pcall(require"telescope.builtin".git_files, opts)
    end

    if not ok then
        require"telescope.builtin".find_files(opts)
    end
end

M.updated_files = function()
    local opts = {} -- define here if you want to define something

    local ok

    if helpers.is_arc_env() then
        ok = pcall(require("telescope").extensions.arc.status, opts)
    else
        ok = pcall(require("telescope.builtin").git_status, opts)
    end

    if not ok then
        require"telescope.builtin".find_files(opts)
    end
end

M.pull_request = function()
    local opts = {} -- define here if you want to define something

    local ok

    if helpers.is_arc_env() then
        ok = true
        utils.notify("builtin.vcs.pull_request.", {
            msg = "Not implemented for arc",
            level = "WARN",
        })
    else
        ok = pcall(require"moonw1nd.telescope.gh".pull_request, opts)
    end

    if not ok then
        utils.notify("builtin.vcs.pull_request", {
            msg = "Unexpected error on show pull request",
            level = "ERROR",
        })
    end
end

M.my_pull_request = function()
    local opts = {} -- define here if you want to define something

    local ok

    if helpers.is_arc_env() then
        ok = true
        utils.notify("builtin.vcs.my_pull_request.", {
            msg = "Not implemented for arc",
            level = "WARN",
        })
    else
        ok = pcall(require"moonw1nd.telescope.gh".my_pull_request, opts)
    end

    if not ok then
        utils.notify("builtin.vcs.my_pull_request", {
            msg = "Unexpected error on show pull request",
            level = "ERROR",
        })
    end
end

M.reviews_pull_request = function()
    local opts = {} -- define here if you want to define something

    local ok

    if helpers.is_arc_env() then
        ok = true
        utils.notify("builtin.vcs.reviews_pull_request", {
            msg = "Not implemented for arc",
            level = "WARN",
        })
    else
        ok = pcall(require"moonw1nd.telescope.gh".reviews_pull_request, opts)
    end

    if not ok then
        utils.notify("builtin.vcs.reviews_pull_request", {
            msg = "Unexpected error on show pull request",
            level = "ERROR",
        })
    end
end

return M
