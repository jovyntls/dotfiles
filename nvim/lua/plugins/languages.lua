-- configs for language support (excludes LSP)

local js_filetypes = { 'javascript', 'javascriptreact', 'jsx', 'jsx_pretty', 'typescript', 'typescriptreact', 'tsx' }

return {
  {
    'lervag/vimtex',
    ft = { 'tex' },
    config = function()
      vim.g.tex_flavor = 'latex'
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_quickfix_mode = 0
      vim.opt.conceallevel = 1
      vim.g.tex_conceal = 'abdmg'
    end
  },

  {
    'sirver/ultisnips',
    ft = { 'tex' },
    init = function()
      vim.g.UltiSnipsExpandTrigger = '<tab>'
      vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
      vim.env.HOME = vim.fn.expand('~')
      vim.g.UltiSnipsSnippetsDir = vim.env.HOME .. '/.config/nvim/my_snippets'
      vim.g.UltiSnipsSnippetDirectories = { vim.env.HOME .. '/.config/nvim/my_snippets' }
    end
  },

  { 'dylon/vim-antlr',          ft = { 'antlr4' } },
  { 'pangloss/vim-javascript',  ft = js_filetypes },
  { 'MaxMEllon/vim-jsx-pretty', ft = js_filetypes },

}
