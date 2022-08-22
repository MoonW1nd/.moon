-- local TEMPLATE_TASK = '* TODO %?\n%u';
-- local TEMPLATE_TASK_WITH_FILE_LINK = '* TODO %?\n%u\n%a';

-- require('orgmode').setup({
--   org_agenda_files = {'~/orgs/**/*'},
--   org_default_notes_file = '~/orgs/inbox.org',
--   org_tags_column = 0,
--   org_indent_mode = 'noindent',
--   win_split_mode = 'auto',
--   org_capture_templates = {
--      t = 'Taks',
--      ti = { description = 'Task', template = TEMPLATE_TASK },
--      tw = { description = 'Task', template = TEMPLATE_TASK, target = '~/orgs/work/work.org' },
--      tv = { description = 'Task', template = TEMPLATE_TASK, target = '~/orgs/work/vim.org' },
--
--      f = 'Tasks with file link',
--      fi = { description = 'Task with file link', template = TEMPLATE_TASK_WITH_FILE_LINK },
--      fw = { description = 'Task with file link', template = TEMPLATE_TASK_WITH_FILE_LINK, target = "~/orgs/work/work.org"},
--      fv = { description = 'Task with file link', template = TEMPLATE_TASK_WITH_FILE_LINK, target = "~/orgs/work/vim.org"},
--   },
--   mappings = {
--       org = {
--           org_toggle_checkbox = "<leader>tt"
--       }
--   }
-- })
--
require('neorg').setup {
    load = {
        ["core.defaults"] = {
            config = {
            }
        },
        ["core.norg.concealer"] = {},
        ["core.norg.manoeuvre"] = {},
        ["core.norg.journal"] = {},
        ["core.export"] = {},
        ["core.export.markdown"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/org/notes/work/",
                    life = "~/org/notes/life/",
                    dev = "~/org/notes/dev/",
                    all = "~/org/",
                }
            }
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.norg.completion"] = {
            config =  {
                engine = 'nvim-cmp'
            }
        },
        ["core.gtd.base"] = {
            config = {
                workspace = "all",
            }
        },
        ["core.integrations.telescope"] = {},
        ["core.norg.qol.toc"] = {},
        -- ["external.gtd-project-tags"] = {},
    }
}

local neorg_callbacks = require("neorg.callbacks")

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
    -- Map all the below keybinds only when the "norg" mode is active
    keybinds.map_event_to_mode("norg", {
        n = { -- Bind keys in normal mode
            { "<C-f>", "core.integrations.telescope.insert_file_link" },
        },

        i = { -- Bind in insert mode
            { "<C-f>", "core.integrations.telescope.insert_file_link" },
        },
    }, {
        silent = true,
        noremap = true,
    })

    keybinds.map_event_to_mode("all", {
        n = { -- Bind keys in normal mode
            { "]]", "core.integrations.treesitter.next.heading" },
            { "[[", "core.integrations.treesitter.previous.heading" },
        },
    }, {
        silent = true,
        noremap = true,
    })
end)
