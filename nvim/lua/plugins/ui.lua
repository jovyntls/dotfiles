return {
  {
    'jovyntls/seoul256.vim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.seoul256_background = 235
      vim.cmd([[colorscheme seoul256]])
    end
  },

  {
    'itchyny/lightline.vim',
    dependencies = { 'jovyntls/seoul256.vim' },
    config = function()
      vim.g.lightline = {
        active = {
          left = {
            { 'mode',     'paste' },
            { 'readonly', 'filename', 'modified' }
          },
          right = {
            { 'lineinfo' },
            { 'percent' },
            { 'filetype' }
          }
        },
        inactive = {
          left = {
            { 'filename' }
          },
          right = {}
        },
        colorscheme = 'seoul256'
      }
    end
  }
}
