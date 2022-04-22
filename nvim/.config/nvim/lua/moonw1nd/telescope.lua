local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.finders")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local telescope_gh_actions = require("telescope._extensions.gh_actions")
-- For arc integration
local utils = require("telescope.utils")
local putils = require("telescope.previewers.utils")
local from_entry = require("telescope.from_entry")
local make_entry = require("telescope.make_entry")
local Path = require "plenary.path"
local entry_display = require "telescope.pickers.entry_display"

require("telescope").setup(
    {
        defaults = {
            preview = {timeout = 500, msg_bg_fillchar = ""},
            layout_strategy = "bottom_pane",
            layout_config = {
                bottom_pane = {height = 0.9, prompt_position = "bottom"},
            },
            file_sorter = sorters.get_fzy_sorter,
            file_ignore_patterns = {".git", "node_modules", "package-lock.json"},
            prompt_prefix = " λ ",
            color_devicons = true,

            file_previewer = previewers.vim_buffer_cat.new,
            grep_previewer = previewers.vim_buffer_vimgrep.new,
            qflist_previewer = previewers.vim_buffer_qflist.new,

            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<esc>"] = actions.close,
                    ["<C-x>"] = false,
                    ["<C-q>"] = actions.send_selected_to_qflist +
                        actions.open_qflist,
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = false,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    }
)

require("telescope").load_extension("git_worktree")
require("telescope").load_extension("fzf")
require("telescope").load_extension("gh")
require("telescope").load_extension("harpoon")

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files(
        {prompt_title = "< Dotfiles >", cwd = vim.env.DOTFILES, hidden = true}
    )
end

M.rg = function()
    require("telescope.builtin").grep_string {
        path_display = {"truncate"},
        search = vim.fn.input("Rg  "),
        only_sort_text = true,
        use_regex = true,
        full = true,
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
        },
    }
end

-- Work action pluggin {{{
local COMAND_ACTION_DESCRIPTION = {
    ["SYNC_AND_RESTART_SERVER"] = "Sync and restart server",
    ["RESTART_SERVER"] = "Restart server",
    ["REBILD_SERVER"] = "Rebuild server",
    ["RESTART_WEBPACK"] = "Restart webpack",
    ["MAKE_TS"] = "Run check types TS [MakeTs]",
    ["MAKE_ESLINT"] = "Run check code style [MakeEslint]",
    ["MAKE_ESLINT_FILE"] = "Run check code style [MakeEslintFile]",
    ["STANDUP"] = "Open zoom standup [Affiliate]",
    ["TECH_MEETING"] = "Open zoom tech meeting [Affiliate]",

    -- Not implemented
    ["CREATE_PR"] = "Create PR [Git]",
    ["RESTART_MULTITESTING"] = "Restart multitesting [Git]",
    ["UPDATE_PR"] = "Update PR [Git]",
}

local execute_working_command = function(prompt_bufnr)
    local selection = action_state.get_selected_entry()

    actions.close(prompt_bufnr)

    local tmp_table = vim.split(selection.value, "\t");

    if vim.tbl_isempty(tmp_table) then
        return
    end

    local command_action = tmp_table[1]

    if command_action == COMAND_ACTION_DESCRIPTION.REBILD_SERVER then
        vim.api.nvim_command("RebildServer")
    elseif command_action == COMAND_ACTION_DESCRIPTION.RESTART_SERVER then
        vim.api.nvim_command("ReloadServer")
    elseif command_action == COMAND_ACTION_DESCRIPTION.SYNC_AND_RESTART_SERVER then
        vim.api.nvim_command("SyncAndReloadServer")
    elseif command_action == COMAND_ACTION_DESCRIPTION.RESTART_WEBPACK then
        vim.api.nvim_command("ReloadWebpack")
    elseif command_action == COMAND_ACTION_DESCRIPTION.MAKE_TS then
        vim.api.nvim_command("MakeTs")
    elseif command_action == COMAND_ACTION_DESCRIPTION.MAKE_ESLINT then
        vim.api.nvim_command("MakeEslint")
    elseif command_action == COMAND_ACTION_DESCRIPTION.MAKE_ESLINT_FILE then
        vim.api.nvim_command("MakeEslintFile")
    elseif command_action == COMAND_ACTION_DESCRIPTION.STANDUP then
        vim.api.nvim_command("Standup")
    elseif command_action == COMAND_ACTION_DESCRIPTION.TECH_MEETING then
        vim.api.nvim_command("TechMeeting")
    end
end

M.work_scripts = function()
    local command_actions = {
        COMAND_ACTION_DESCRIPTION.RESTART_SERVER,
        COMAND_ACTION_DESCRIPTION.SYNC_AND_RESTART_SERVER,
        COMAND_ACTION_DESCRIPTION.RESTART_WEBPACK,
        COMAND_ACTION_DESCRIPTION.REBILD_SERVER,
        COMAND_ACTION_DESCRIPTION.MAKE_TS,
        COMAND_ACTION_DESCRIPTION.MAKE_ESLINT,
        COMAND_ACTION_DESCRIPTION.MAKE_ESLINT_FILE,
        COMAND_ACTION_DESCRIPTION.STANDUP,
        COMAND_ACTION_DESCRIPTION.TECH_MEETING,
    }

    local dropdownTheme = require("telescope.themes").get_dropdown();

    local opts = {
        prompt_title = "Actions",
        finder = finders.new_table(command_actions),
        sorter = conf.generic_sorter(),
        attach_mappings = function(_, _)
            actions.select_default:replace(execute_working_command)
            return true
        end,
    }

    local picker = pickers.new(dropdownTheme, opts)
    picker:find()
end
-- }}}
--

M.is_arc_env = function()
    local scripts = vim.api.nvim_exec(
                        "!arc rev-parse --is-inside-work-tree 2>/dev/null || echo 'false'",
                        true
                    )

    local isArc = false

    for script in scripts:gmatch("[^\r\n]+") do
        if script == "true" then
            isArc = true
        end
    end

    return isArc
end

M.arc_files = function(opts)
    if opts.is_bare then
        utils.notify(
            "builtin.arc.files", {
                msg = "This operation must be run in a work tree",
                level = "ERROR",
            }
        )
        return
    end

    -- local show_untracked = utils.get_default(opts.show_untracked, true)
    -- By creating the entry maker after the cwd options,
    -- we ensure the maker uses the cwd options when being created.
    opts.entry_maker = vim.F.if_nil(
                           opts.entry_maker, make_entry.gen_from_file(opts)
                       )
    local arc_command = vim.F.if_nil(
                            opts.git_command, {"arc", "ls-files", "--cached"}
                        )

    pickers.new(
        opts, {
            prompt_title = "Arc Files",
            finder = finders.new_oneshot_job(
                vim.tbl_flatten {
                    arc_command,
                    -- show_untracked and "--others" or nil,
                }, opts
            ),
            previewer = conf.file_previewer(opts),
            sorter = conf.file_sorter(opts),
        }
    ):find()
end

local set_opts_cwd = function(opts)
    if opts.cwd then
        opts.cwd = vim.fn.expand(opts.cwd)
    else
        opts.cwd = vim.loop.cwd()
    end

    -- Find root of git directory and remove trailing newline characters
    local arc_root, ret = utils.get_os_command_output(
                              {"arc", "rev-parse", "--show-toplevel"}, opts.cwd
                          )
    local use_arc_root = utils.get_default(opts.use_git_root, true)

    if ret ~= 0 then
        local in_worktree = utils.get_os_command_output(
                                {"arc", "rev-parse", "--is-inside-work-tree"},
                                opts.cwd
                            )

        if in_worktree[1] ~= "true" then
            error(opts.cwd .. " is not a arc directory")
        end
    else
        if use_arc_root then
            opts.cwd = arc_root[1]
        end
    end
end

M.project_files = function()
    local opts = {} -- define here if you want to define something

    local ok

    if M.is_arc_env() then
        ok = pcall(M.arc_files, opts)
    else
        ok = pcall(require"telescope.builtin".git_files, opts)
    end

    if not ok then
        require"telescope.builtin".find_files(opts)
    end
end

local git_icon_defaults = {
    added = "+",
    changed = "~",
    copied = ">",
    deleted = "-",
    renamed = "➡",
    unmerged = "‡",
    untracked = "?",
}

function M.gen_from_arc_status(opts)
    opts = opts or {}

    local col_width = ((opts.git_icons and opts.git_icons.added) and
                          opts.git_icons.added:len() + 2) or 2
    local displayer = entry_display.create {
        separator = "",
        items = {{width = col_width}, {width = col_width}, {remaining = true}},
    }

    local icons =
        vim.tbl_extend("keep", opts.git_icons or {}, git_icon_defaults)

    local git_abbrev = {
        ["A"] = {icon = icons.added, hl = "TelescopeResultsDiffAdd"},
        ["U"] = {icon = icons.unmerged, hl = "TelescopeResultsDiffAdd"},
        ["M"] = {icon = icons.changed, hl = "TelescopeResultsDiffChange"},
        ["C"] = {icon = icons.copied, hl = "TelescopeResultsDiffChange"},
        ["R"] = {icon = icons.renamed, hl = "TelescopeResultsDiffChange"},
        ["D"] = {icon = icons.deleted, hl = "TelescopeResultsDiffDelete"},
        ["?"] = {icon = icons.untracked, hl = "TelescopeResultsDiffUntracked"},
    }

    local make_display = function(entry)
        local x = string.sub(entry.status, 1, 1)
        local y = string.sub(entry.status, -1)
        local status_x = git_abbrev[x] or {}
        local status_y = git_abbrev[y] or {}

        local empty_space = " "
        return displayer {
            {status_x.icon or empty_space, status_x.hl},
            {status_y.icon or empty_space, status_y.hl},
            entry.value,
        }
    end

    return function(entry)
        if entry == "" then
            return nil
        end
        local mod, file = string.match(entry, "(..).*%s[->%s]?(.+)")

        return {
            value = file,
            status = mod,
            ordinal = entry,
            display = make_display,
            path = Path:new({opts.cwd, file}):absolute(),
        }
    end
end

local function defaulter(f, default_opts)
    default_opts = default_opts or {}
    return {
        new = function(opts)
            if conf.preview == false and not opts.preview then
                return false
            end
            opts.preview = type(opts.preview) ~= "table" and {} or opts.preview
            if type(conf.preview) == "table" then
                for k, v in pairs(conf.preview) do
                    opts.preview[k] = vim.F.if_nil(opts.preview[k], v)
                end
            end
            return f(opts)
        end,
        __call = function()
            local ok, err = pcall(f(default_opts))
            if not ok then
                error(debug.traceback(err))
            end
        end,
    }
end

M.arc_file_diff = defaulter(
                      function(opts)
        return previewers.new_buffer_previewer {
            title = "Arc File Diff Preview",
            get_buffer_by_name = function(_, entry)
                return entry.value
            end,

            define_preview = function(self, entry, status)
                if entry.status and
                    (entry.status == "??" or entry.status == "A ") then
                    local p = from_entry.path(entry, true)

                    if p == nil or p == "" then
                        return
                    end

                    conf.buffer_previewer_maker(
                        p, self.state.bufnr, {
                            bufname = self.state.bufname,
                            winid = self.state.winid,
                        }
                    )
                else
                    putils.job_maker(
                        {"arc", "diff", "--git", entry.value}, self.state.bufnr,
                        {
                            value = entry.value,
                            bufname = self.state.bufname,
                            cwd = opts.cwd,
                        }
                    )
                    putils.regex_highlighter(self.state.bufnr, "diff")
                end
            end,
        }
    end, {}
                  )

M.action_arc_staging_toggle = function(gen_new_finder)
    return function(prompt_bufnr)
        local cwd = action_state.get_current_picker(prompt_bufnr).cwd
        local selection = action_state.get_selected_entry()
        if selection == nil then
            utils.__warn_no_selection "actions.arc_staging_toggle"
            return
        end
        if selection.status:sub(2) == " " then
            utils.get_os_command_output(
                {"arc", "reset", "HEAD", selection.value}, cwd
            )
        else
            utils.get_os_command_output({"arc", "add", selection.value}, cwd)
        end

        action_state.get_current_picker(prompt_bufnr):refresh(
            gen_new_finder(), {reset_prompt = true}
        )
    end
end

M.arc_status = function(opts)
    set_opts_cwd(opts)

    if opts.is_bare then
        utils.notify(
            "moonw1nd.telescope.arc_status", {
                msg = "This operation must be run in a work tree",
                level = "ERROR",
            }
        )
        return
    end

    local gen_new_finder = function()
        local expand_dir = utils.if_nil(opts.expand_dir, true, opts.expand_dir)
        local arc_cmd = {"arc", "status", "-s", "."}

        if expand_dir then
            table.insert(arc_cmd, #arc_cmd - 1, "-u")
        end

        local output = utils.get_os_command_output(arc_cmd, opts.cwd)

        if #output == 0 then
            print "No changes found"
            utils.notify(
                "builtin.git_status", {msg = "No changes found", level = "WARN"}
            )
            return
        end

        return finders.new_table {
            results = output,
            entry_maker = vim.F.if_nil(
                opts.entry_maker, M.gen_from_arc_status(opts)
            ),
        }
    end

    local initial_finder = gen_new_finder()
    if not initial_finder then
        return
    end

    pickers.new(
        opts, {
            prompt_title = "Arc Status",
            finder = initial_finder,
            previewer = M.arc_file_diff.new(opts),
            sorter = conf.file_sorter(opts),
            attach_mappings = function(_, map)
                map("i", "<tab>", M.action_arc_staging_toggle(gen_new_finder))
                map("n", "<tab>", M.action_arc_staging_toggle(gen_new_finder))
                return true
            end,
        }
    ):find()
end

M.updated_files = function()
    local opts = {} -- define here if you want to define something

    local ok

    if M.is_arc_env() then
        ok = pcall(M.arc_status, opts)
    else
        ok = pcall(require("telescope.builtin").git_status, opts)
    end

    if not ok then
        require"telescope.builtin".find_files(opts)
    end
end

-- Переписаный модуль для preview github так как lua os.execute не работал
M.gh_web_view = function(type)
    return function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local tmp_table = vim.split(selection.value, "\t");

        if vim.tbl_isempty(tmp_table) then
            return
        end

        vim.api.nvim_command(
            "silent !gh " .. type .. " view --web " .. tmp_table[1]
        )
        actions.close(prompt_bufnr)
    end
end

-- Mapping for telescope github
local gh_pr_attach_mappings = function(_, map)
    map("i", "<c-e>", telescope_gh_actions.gh_pr_v_toggle)
    -- use mapping <c-m> crash mappings
    map("i", "<c-c>", telescope_gh_actions.gh_pr_merge)
    map("i", "<c-g>", telescope_gh_actions.gh_pr_checkout)
    actions.select_default:replace(M.gh_web_view("pr"))
    return true
end

M.pull_request = function()
    require("telescope").extensions.gh.pull_request(
        {attach_mappings = gh_pr_attach_mappings}
    )
end

M.my_pull_request = function()
    require("telescope").extensions.gh.pull_request(
        {author = "@me", attach_mappings = gh_pr_attach_mappings}
    )
end

M.reviews_pull_request = function()
    require("telescope").extensions.gh.pull_request(
        {
            search = "review-requested:@me",
            attach_mappings = function(_, map)
                map("i", "<c-e>", telescope_gh_actions.gh_pr_v_toggle)
                map("i", "<c-g>", telescope_gh_actions.gh_pr_checkout)
                actions.select_default:replace(M.gh_web_view("pr"))
                return true
            end,
        }
    )
end

M.search_wiki = function()
    require("telescope.builtin").find_files(
        {
            prompt_title = "< Wiki >",
            file_ignore_patterns = {".git"},
            cwd = vim.env.WIKI_PATH,
            hidden = true,
        }
    )
end

local function refactor(prompt_bufnr)
    local content = action_state.get_selected_entry(prompt_bufnr)
    require("telescope.actions").close(prompt_bufnr)
    require("refactoring").refactor(content.value)
end

M.refactors = function()
    local opts = require("telescope.themes").get_cursor()

    pickers.new(
        opts, {
            prompt_title = "refactors",
            finder = finders.new_table(
                {results = require("refactoring").get_refactors()}
            ),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(_, map)
                map("i", "<CR>", refactor)
                map("n", "<CR>", refactor)
                return true
            end,
        }
    ):find()
end

M.git_branches = function()
    require("telescope.builtin").git_branches(
        {
            attach_mappings = function(_, map)
                map("i", "<c-d>", actions.git_delete_branch)
                map("n", "<c-d>", actions.git_delete_branch)
                return true
            end,
        }
    )
end

M.my_fd = function(opts)
    opts = opts or {}
    opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    require"telescope.builtin".find_files(opts)
end

return M
