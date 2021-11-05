local use = require('packer').use

require('packer').startup(function()
  -- Plugin/Package manager
  use 'wbthomason/packer.nvim'

  -- Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more.
  -- The plugin provides mappings to easily delete, change and add such surroundings in pairs.
  -- :help surround
  use { 'tpope/vim-surround', tag = 'v2.2', }

  -- Super fast git decorations
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    tag = 'release',
  }

  -- Hop is an EasyMotion-like plugin allowing you to jump anywhere in a document with as few keystrokes as possible.
  -- :help hop
  -- :help hop.setup
  -- :help hop-config
  use { 'phaazon/hop.nvim', branch = 'v1', }

  -- GitHub theme for Neovim
  use 'projekt0n/github-nvim-theme'
end)

vim.o.number = true
vim.o.relativenumber = true

-- Remap space as leader key
vim.api.nvim_set_keymap('', '<space>', '<nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('hop').setup {
  keys = 'asdfjklreuio',
}

vim.api.nvim_set_keymap('n', '<leader>j', [[<cmd>lua require'hop'.hint_char1()<cr>]], {})
vim.api.nvim_set_keymap('v', '<leader>j', [[<cmd>lua require'hop'.hint_char1()<cr>]], {})

require('gitsigns').setup {
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn' },
    change       = { hl = 'GitSignsChange', text = 'm', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
  },
}

vim.cmd [[colorscheme github_light]]

require('github-theme').setup {
  theme_style = 'light_default',
}
