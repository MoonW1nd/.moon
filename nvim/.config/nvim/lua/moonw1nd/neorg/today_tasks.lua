local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

local popup = Popup({
  position = "50%",
  size = {
    width = "80%",
    height = "60%",
  },
  enter = true,
  focusable = true,
  zindex = 50,
  relative = "editor",
  border = {
    padding = {
      top = 2,
      bottom = 2,
      left = 3,
      right = 3,
    },
    style = "rounded",
    text = {
      top = " Today tasks ",
      top_align = "center",
    },
  },
  buf_options = {
    modifiable = true,
    readonly = false,
  },
  win_options = {
    winblend = 10,
    winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
  },
})


return function ()
    -- mount/open the component
    popup:mount()

    -- set content
    -- vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { "Hello World" })

    vim.cmd('silent execute "!~/dotfiles/scripts/org/updateStatus.sh" | edit ~/org/notes/work/status.norg')

    -- unmount component when cursor leaves buffer
    popup:on({ event.BufWinLeave }, function()
        vim.schedule(function()
            popup:unmount()
        end)
    end, { once = true })

    popup:on(event.WinClosed, function()
      popup:unmount()
    end, { once = true })

    popup:on(event.BufLeave, function()
      popup:unmount()
    end, { once = true })

end
