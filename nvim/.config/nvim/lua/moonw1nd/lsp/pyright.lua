local nvim_lsp = require("lspconfig")
local lsp_settings = require("moonw1nd.lsp.settings");


nvim_lsp.pyright.setup{
    capabilities = lsp_settings.capabilities,
    flags = {debounce_text_changes = 150},
    on_attach = lsp_settings.set_keymap,
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    -- root_dir = function(fname)
    --     local root_files = {
    --         'pyproject.toml',
    --         'setup.py',
    --         'setup.cfg',
    --         'requirements.txt',
    --         'Pipfile',
    --         'pyrightconfig.json',
    --     }
    --
    --     return nvim_lsp.util.root_pattern(unpack(root_files))(fname) or nvim_lsp.util.find_git_ancestor(fname) or nvim_lsp.util.path.dirname(fname)
    -- end,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "off",
            },
            formatting = {
                provider = "autopep8",
                autopep8Args = "--max-line-length=200"
            },
            linting = {
                flake8Enabled = true,
                flake8Args = "--max-line-length=200"
            },
            sortImports = {
                args = {"--line-length=200", "--multi-line=4"}
            }
        },
    },
}
