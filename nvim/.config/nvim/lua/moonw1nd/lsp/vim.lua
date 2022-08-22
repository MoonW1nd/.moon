local nvim_lsp = require("lspconfig")
local lsp_settings = require("moonw1nd.lsp.settings");

nvim_lsp.vimls.setup {
    capabilities = lsp_settings.capabilities,
    flags = {debounce_text_changes = 150},
    on_attach = lsp_settings.set_keymap,
}
