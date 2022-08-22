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
    addToSet(excludeFilesSet, "coverage")

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

local function create_command_handler(config)
    return function ()
        local opts
        local handler

        if helpers.is_arc_env() then
            handler = config.arc.handler
            opts = config.arc.opts
        else
            handler = config.git.handler
            opts = config.git.opts
        end

        local ok = pcall(handler, opts)

        if not ok then
            utils.notify("builtin.vcs." .. config.name, {
                msg = "Unexpected error in " .. config.name .. " funcion.",
                level = "ERROR",
            })
        end
    end
end

M.status = function()
    local opts = {}

    local ok

    if helpers.is_arc_env() then
        local statusOptions = {
            preview_cmd = {
                staged = "arc diff --git --cached %s | delta --pager='less -SR'",
                unstaged = "arc diff --git %s | delta --pager='less -SR'",
                untracked = "bat --pager='less -SR' -pn %s",
            },
            expand_dir = true,
        }

        ok = pcall(require("telescope").extensions.arc.status, statusOptions)
    else
        ok = pcall(require("telescope.builtin").git_status, opts)
    end

    if not ok then
        require"telescope.builtin".find_files(opts)
    end
end

M.pull_request = create_command_handler({
    name = "pull_request",
    arc = {
        handler = require"telescope".extensions.arc.pr_list,
        opts = {
            flags = {"--subscriber", "moonw1nd", "--status", "open"},
            prompt_title = "Arc PR list"
        }
    },
    git = {
        handler = require"moonw1nd.telescope.gh".pull_request,
        otps = {}
    }
})

M.my_pull_request = create_command_handler({
    name = "my_pull_request",
    arc = {
        handler = require"telescope".extensions.arc.pr_list,
        opts = {
            flags = {"-o"},
            prompt_title = "Arc my PR list"
        }
    },
    git = {
        handler = require"moonw1nd.telescope.gh".my_pull_request,
        otps = {}
    }
})

M.reviews_pull_request = create_command_handler({
    name = "reviews_pull_request",
    arc = {
        handler = require"telescope".extensions.arc.pr_list,
        opts = {
            flags = {"-i", "--shipper", "!moonw1nd"},
            prompt_title = "Arc PR need review"
        }
    },
    git = {
        handler = require"moonw1nd.telescope.gh".reviews_pull_request,
        otps = {}
    }
})

M.commits = create_command_handler({
    name = "commits",
    arc = {
        handler = require("telescope").extensions.arc.commits,
        opts = {
            preview_cmd = "arc show --git %s | delta --pager='less -SR'",
        }
    },
    git = {
        handler = require"telescope.builtin".git_commits,
        otps = {}
    }
})

M.stash = create_command_handler({
    name = "stash",
    arc = {
        handler = require("telescope").extensions.arc.stash,
        opts = {
            preview_cmd = "arc stash show --git %s | delta --pager='less -RS'",
        }
    },
    git = {
        handler = require"telescope.builtin".git_stash,
        otps = {}
    }
})

M.branches = create_command_handler({
    name = "branches",
    arc = {
        handler = require("telescope").extensions.arc.branches,
        opts = {}
    },
    git = {
        handler = require"telescope.builtin".git_branches,
        otps = {}
    }
})

return M
