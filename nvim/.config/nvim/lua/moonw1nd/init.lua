require('moonw1nd.pluggings');
require('moonw1nd.treesitter');
require('moonw1nd.lsp-config');
require('moonw1nd.telescope');
require('moonw1nd.refactoring');

vim.env.DOTFILES = '~/dotfiles/'

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end
