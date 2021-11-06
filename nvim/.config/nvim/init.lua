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

  -- A blazing fast and easy to configure Neovim statusline written in Lua
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  }
end)

vim.o.number = true
vim.o.relativenumber = true

-- Remap space as leader key
vim.api.nvim_set_keymap('', '<space>', '<nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Hop
require('hop').setup {
  create_hl_autocmd = false,
}

-- override default highlighting
vim.api.nvim_command('augroup HopInitHighlight')
vim.api.nvim_command('autocmd!')
vim.api.nvim_command('autocmd ColorScheme * \z
  highlight default HopNextKey guifg=#000000 | \z
  highlight default HopNextKey1 guifg=#000000 | \z
  highlight default HopNextKey2 guifg=#000000 | \z
  highlight default HopUnmatched guifg=#bbbbbb | \z
  highlight default link HopCursor Cursor'
)
vim.api.nvim_command('augroup end')

vim.api.nvim_set_keymap('n', '<leader>j', [[<cmd>lua require'hop'.hint_char1()<cr>]], {})
vim.api.nvim_set_keymap('v', '<leader>j', [[<cmd>lua require'hop'.hint_char1()<cr>]], {})


-- Gitsigns
require('gitsigns').setup {
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '+', },
    change       = { hl = 'GitSignsChange', text = '*', },
    delete       = { hl = 'GitSignsDelete', text = '-', },
    topdelete    = { hl = 'GitSignsDelete', text = '-', },
    changedelete = { hl = 'GitSignsChange', text = '~', },
  },
}


vim.cmd [[colorscheme github_light]]

require('github-theme').setup {
  theme_style = 'light_default',
}

require('lualine').setup{
  theme = 'github_light_default',
}
