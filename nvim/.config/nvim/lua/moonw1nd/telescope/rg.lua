return function()
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
