local nvim_lsp = require("lspconfig")

nvim_lsp.stylelint_lsp.setup {
    settings = {stylelintplus = {autoFixOnSave = true, autoFixOnFormat = true}},
}
