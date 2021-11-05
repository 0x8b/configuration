local use = require('packer').use

require('packer').startup(function()
  -- plugin/package manager
  use 'wbthomason/packer.nvim'

  -- Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more.
  -- The plugin provides mappings to easily delete, change and add such surroundings in pairs.
  -- :help surround
  use { 'tpope/vim-surround', tag = 'v2.2', }

  -- Hop is an EasyMotion-like plugin allowing you to jump anywhere in a document with as few keystrokes as possible.
  -- :help hop
  -- :help hop.setup
  -- :help hop-config
  use { 'phaazon/hop.nvim', branch = 'v1',
    config = function()
      require('hop').setup {
        keys = 'etovxqpdygfblzhckisuran',
      }
    end,
  }
end)
