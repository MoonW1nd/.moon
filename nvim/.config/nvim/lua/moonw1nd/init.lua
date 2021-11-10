require("moonw1nd.plugins");
require("moonw1nd.cmp");
require("moonw1nd.lsp")
require("moonw1nd.lsp_signature")
require("moonw1nd.treesitter");
require("moonw1nd.harpoon")
require("moonw1nd.telescope");
require("moonw1nd.refactoring");
require("moonw1nd.comment");
require("moonw1nd.env")

-- luacheck: globals P R RELOAD
P = function(v)
    print(vim.inspect(v))
    return v
end

if pcall(require, "plenary") then
    RELOAD = require("plenary.reload").reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end
