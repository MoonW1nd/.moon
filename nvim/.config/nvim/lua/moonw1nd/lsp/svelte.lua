local nvim_lsp = require("lspconfig")
local lsp_settings = require("moonw1nd.lsp.settings");

nvim_lsp.svelte.setup {
    -- for postfix snippets and analyzers
    capabilities = lsp_settings.capabilities,
    on_attach = lsp_settings.set_keymap,
}
