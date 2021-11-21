require("moonw1nd.plugins");
require("moonw1nd.cmp");
require("moonw1nd.lsp")
require("moonw1nd.lsp_signature")
require("moonw1nd.treesitter");
require("moonw1nd.harpoon")
require("moonw1nd.telescope");
-- Errors on new version need update
-- require("moonw1nd.refactoring");
require("moonw1nd.comment");
require("moonw1nd.env")

function _G.ReloadConfig()
    for name, _ in pairs(package.loaded) do
        if name:match("^moonw1nd") or name:match("lsp") then
            package.loaded[name] = nil
        end
    end

    vim.api.nvim_command("so $MYVIMRC")
    dofile(vim.fn.expand("$HOME/.config/nvim/lua/moonw1nd/init.lua"))

    print("Vim config reloaded!")
end

vim.api.nvim_set_keymap(
    "n", "<localleader>r", "<Cmd>lua ReloadConfig()<CR>",
    {silent = true, noremap = true}
)

vim.cmd("command! ReloadConfig lua ReloadConfig()")
