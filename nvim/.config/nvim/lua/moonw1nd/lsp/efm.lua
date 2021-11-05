local nvim_lsp = require("lspconfig")

nvim_lsp.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {"lua"},
    flags = {debounce_text_changes = 150},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {
                    lintCommand = "luacheck --globals vim --filename ${INPUT} --formatter plain -",
                    lintStdin = true,
                    lintFormats = {"%f:%l:%c: %m"},
                },
                {
                    formatCommand = "lua-format -i --config='/Users/moonw1nd/dotfiles/.lua-format'",
                    formatStdin = true,
                },
            },
        },
    },
}
