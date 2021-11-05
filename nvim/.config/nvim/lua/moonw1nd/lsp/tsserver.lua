local nvim_lsp = require("lspconfig")
local ts_utils = require("nvim-lsp-ts-utils")
local lsp_settings = require("moonw1nd.lsp.settings");

nvim_lsp.tsserver.setup {
    capabilities = lsp_settings.capabilities,
    flags = {debounce_text_changes = 150},
    on_attach = function(client, bufnr)
        -- defaults
        ts_utils.setup {
            debug = false,
            disable_commands = false,
            enable_import_on_completion = false,

            -- import all
            import_all_timeout = 5000, -- ms
            -- lower numbers indicate higher priority
            import_all_priorities = {
                same_file = 1, -- add to existing import statement
                local_files = 2, -- git files or files with relative path markers
                buffer_content = 3, -- loaded buffer content
                buffers = 4, -- loaded buffer names
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,

            -- update imports on file move
            update_imports_on_move = false,
            require_confirmation_on_move = false,
            watch_dir = nil,

            -- filter diagnostics
            filter_out_diagnostics_by_severity = {},
            filter_out_diagnostics_by_code = {},
        }

        lsp_settings.set_keymap(client, bufnr)
    end,
}
