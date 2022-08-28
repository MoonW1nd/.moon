-- Intergration Comment.vim with nvim-ts-context-commentstring
--
-- @see https://github.com/numToStr/Comment.nvim
-- @see https://github.com/JoosepAlviste/nvim-ts-context-commentstring

require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
