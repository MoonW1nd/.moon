local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")
local lsp_settings = require("moonw1nd.lsp.settings");
local lastRootPath = nil
local gopath = os.getenv("GOPATH")
if gopath == nil then
    gopath = ""
end
local gopathmod = gopath .. "/pkg/mod"

nvim_lsp.gopls.setup {
    cmd = {"gopls", "serve"},
    root_dir = function(fname)
        local fullpath = vim.fn.expand(fname, ":p")
        if string.find(fullpath, gopathmod) and lastRootPath ~= nil then
            return lastRootPath
        end
        lastRootPath = util.root_pattern("go.mod", ".git")(fname)
        return lastRootPath
    end,
    -- for postfix snippets and analyzers
    capabilities = lsp_settings.capabilities,
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {unusedparams = true, shadow = true},
            staticcheck = true,
        },
    },
    on_attach = lsp_settings.set_keymap,
}

local M = {}

M.goimports = function(timeout_ms)
    local context = {only = {"source.organizeImports"}}
    vim.validate {context = {context, "t", true}}

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(
                       0, "textDocument/codeAction", params, timeout_ms
                   )
    if not result or next(result) == nil then
        return
    end
    local actions = result[1].result
    if not actions then
        return
    end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit)
        end
        if type(action.command) == "table" then
            vim.lsp.buf.execute_command(action.cmmand)
        end
    else
        vim.lsp.buf.execute_command(action)
    end
end

return M
