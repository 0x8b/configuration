local opt = vim.opt
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


-- Remap space as leader key
vim.api.nvim_set_keymap('', '<space>', '<nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

opt.scrolloff = 3
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'split'
opt.number = true
opt.relativenumber = true

local function remap(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { silent = true, noremap = true })
end

remap('n', '<leader>s', [[:%s//g<left><left>]])
remap('n', '<leader>q', [[<cmd>q<cr>]])
remap('n', '<leader>w', [[<cmd>w<cr>]])
remap('n', '<leader>x', [[<cmd>wq<cr>]])


-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
  ]],
  false)

-- Hop
require('hop').setup {
  create_hl_autocmd = false,
}

-- override default highlighting
vim.api.nvim_exec(
 [[
 augroup HopInitHighlight
   autocmd!
   autocmd ColorScheme * highlight default HopNextKey guifg=#000000 | highlight default HopNextKey1 guifg=#000000 | highlight default HopNextKey2 guifg=#000000 | highlight default HopUnmatched guifg=#bbbbbb | highlight default link HopCursor Cursor
 augroup end
 ]],
 false)

remap('n', '<leader>j', [[<cmd>lua require'hop'.hint_char1()<cr>]])
remap('v', '<leader>j', [[<cmd>lua require'hop'.hint_char1()<cr>]])


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
