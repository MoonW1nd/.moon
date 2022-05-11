local utils = require("telescope.utils")

local M = {}

M.set_opts_cwd = function(opts)
    if opts.cwd then
        opts.cwd = vim.fn.expand(opts.cwd)
    else
        opts.cwd = vim.loop.cwd()
    end

    -- Find root of git directory and remove trailing newline characters
    local arc_root, ret = utils.get_os_command_output(
        {"arc", "rev-parse", "--show-toplevel"},
        opts.cwd
    )
    local use_arc_root = utils.get_default(opts.use_arc_root, false)

    if ret ~= 0 then
        local in_worktree = utils.get_os_command_output(
            {"arc", "rev-parse", "--is-inside-work-tree"},
            opts.cwd
        )

        if in_worktree[1] ~= "true" then
            error(opts.cwd .. " is not a arc directory")
        end
    else
        if use_arc_root then
            opts.cwd = arc_root[1]
        end
    end
end

M.is_arc_env = function()
    local scripts = vim.api.nvim_exec(
        "!arc rev-parse --is-inside-work-tree 2>/dev/null || echo 'false'",
        true
    )

    local is_arc_env = false

    for script in scripts:gmatch("[^\r\n]+") do
        if script == "true" then
            is_arc_env = true
        end
    end

    return is_arc_env
end

return M
