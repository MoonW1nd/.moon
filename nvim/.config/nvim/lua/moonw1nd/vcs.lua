local M = {}

M.command = function ()
    -- Support completeon function
    local command = vim.fn.input("VCS: ")

    if command ~= "" then
        vim.api.nvim_command("!~/dotfiles/scripts/vcs.sh " .. command)
    end
end

return M
