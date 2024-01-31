return {
  {
    'Raimondi/delimitMate',
    init = function()
      vim.g.delimitMate_expand_cr = 1 -- add newline after expanding brackets
      vim.g.delimitMate_expand_space = 1
      vim.g.delimitMate_nesting_quotes = { '`', '"' }

      local delimitmateGroup = vim.api.nvim_create_augroup('delimitmateGroup', { clear = true })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'tex',
        group = delimitmateGroup,
        callback = function()
          vim.b.delimitMate_smart_matchpairs = '^%(\\w|!|[£]|[^[:space:][:punct:]])'
          vim.b.delimitMate_quotes = "\" ' $"
        end
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'html', 'vue', 'markdown' },
        group = delimitmateGroup,
        callback = function()
          vim.b.delimitMate_matchpairs = "(:),[:],{:},<:>"
        end
      })
    end
  },

  'tpope/vim-commentary',
  'tpope/vim-surround',

  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {},
    init = function()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  }
}
