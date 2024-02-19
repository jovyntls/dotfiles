return {
  'tpope/vim-fugitive',

  {
    'tpope/vim-rhubarb', -- allow :GBrowse to open github.com
    dependencies = { 'tpope/vim-fugitive' },
    opts = { noremap = true },
    keys = {
      { ',gg', ':GBrowse<CR>', mode = { 'n', 'v' } },
    },
  },

  {
    'junegunn/gv.vim',
    cmd = 'GV',
    keys = {
      { ',G', ':tab G<CR>', mode = { 'n', 'v' } },
    },
    dependencies = { 'tpope/vim-fugitive' }
  }
}
