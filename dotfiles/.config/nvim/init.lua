require('plugins')
require('keymap')
require('mylsp')
require('nvimcmp')

vim.cmd('colorscheme gruvbox')
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.encoding = 'utf-8'
vim.opt.ruler = true

-- code style things
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 8
vim.opt.tabstop = 8
vim.opt.softtabstop = 8

-- lualine
require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      'filename',
      function()
        return vim.fn['nvim_treesitter#statusline'](180)
      end},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

-- nvim-tree-sitter
require('nvim-treesitter.configs').setup {
        highlight = {
                enable = true,
        },
}
