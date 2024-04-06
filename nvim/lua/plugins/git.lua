return {
  {
    'tpope/vim-fugitive',
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fugitive',
        group = vim.api.nvim_create_augroup('FugitiveGroup', { clear = true }),
        callback = function(ev)
          vim.keymap.set('n', ',gp', '<cmd>:Git!push<CR>', { buffer = true })
        end,
      })
    end
  },

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
