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

  {
    'dylon/vim-antlr',
    ft = { 'antlr4' }
  },

  { 'pangloss/vim-javascript',  ft = js_filetypes },
  { 'MaxMEllon/vim-jsx-pretty', ft = js_filetypes },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" }
    },
    config = function()
      -- setup dependencies
      require("mason").setup()
      require("mason-lspconfig").setup{
        ensure_installed = { 'lua_ls', 'pyright' },
      }

      -- setup lsp servers
      local lspconfig = require('lspconfig')
      lspconfig.pyright.setup {}
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          }
        }
      }

      local keyset = vim.keymap.set

      -- global mappings
      keyset('n', '[e', vim.diagnostic.goto_prev)
      keyset('n', ']e', vim.diagnostic.goto_next)
      keyset('n', '<leader>ge', vim.diagnostic.open_float)
      -- keyset('n', '<leader>gl', vim.diagnostic.setloclist)

      vim.diagnostic.config ({ update_in_insert = true, virtual_text = false })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- buffer local mappings
          local opts = { buffer = ev.buf }
          -- goto + show docs
          keyset('n', 'gd', vim.lsp.buf.definition, opts)
          keyset('n', '<leader>gd', vim.lsp.buf.definition, opts)
          keyset('n', '<leader>gD', vim.lsp.buf.declaration, opts)
          keyset('n', '<leader>gt', vim.lsp.buf.type_definition, opts)
          keyset('n', '<leader>gi', vim.lsp.buf.implementation, opts)
          keyset('n', '<leader>gk', vim.lsp.buf.hover, opts)

          -- refactor
          keyset('n', '<leader>gn', vim.lsp.buf.rename, opts)
          keyset('n', '<leader>gr', vim.lsp.buf.references, opts)
          keyset('n', '<leader>ga', vim.lsp.buf.code_action, opts)

          -- format
          vim.keymap.set('n', '<leader>gf', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
    end
  },

  --{
  --  'neoclide/coc.nvim',
  --  branch = 'release',
  --  ft = table_concat(js_filetypes, { 'lua', 'java', 'python', 'python2' }),
  --  cmd = 'Coc',
  --  config = function()
  --    vim.g.coc_global_extensions = {
  --      'coc-tsserver',
  --      'coc-prettier',
  --      'coc-json',
  --      'coc-vetur',
  --      'coc-pyright',
  --      'coc-java',
  --      'coc-lua'
  --    }

  --    -- <from https://github.com/neoclide/coc.nvim>
  --    local keyset = vim.keymap.set

  --    function _G.check_back_space()
  --      local col = vim.fn.col('.') - 1
  --      return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
  --    end

  --    -- Use Tab for trigger completion with characters ahead and navigate
  --    local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
  --    keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
  --      opts)
  --    keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

  --    -- Make <CR> to accept selected completion item or notify coc.nvim to format
  --    keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

  --    opts = { silent = true, nowait = true }
  --    -- i mode: Use <c-space> to trigger completion
  --    keyset("i", "<c-space>", "coc#refresh()", opts)
  --    -- v/x mode: Applying code actions to the selected code block
  --    keyset("x", "<c-space>", "<Plug>(coc-codeaction-selected)", opts)
  --    keyset("n", "<c-space>", "<Plug>(coc-codeaction-selected)", opts)
  --    -- Show all diagnostics
  --    keyset("n", ",gl", ":<C-u>CocList --normal diagnostics<cr>", opts)

  --    opts = { silent = true }
  --    -- Use `[e` and `]e` to navigate diagnostics
  --    keyset("n", "[e", "<Plug>(coc-diagnostic-prev)", opts)
  --    keyset("n", "]e", "<Plug>(coc-diagnostic-next)", opts)
  --    -- GoTo code navigation
  --    keyset("n", "gd", "<Plug>(coc-definition)", opts)
  --    keyset("n", ",gy", "<Plug>(coc-type-definition)", opts)
  --    keyset("n", ",gi", "<Plug>(coc-implementation)", opts)
  --    keyset("n", ",gr", "<Plug>(coc-references)", opts)
  --    -- Use K to show documentation in preview window
  --    function _G.show_docs()
  --      local cw = vim.fn.expand('<cword>')
  --      if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
  --        vim.api.nvim_command('h ' .. cw)
  --      elseif vim.api.nvim_eval('coc#rpc#ready()') then
  --        vim.fn.CocActionAsync('doHover')
  --      else
  --        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  --      end
  --    end

  --    keyset("n", ",gk", '<CMD>lua _G.show_docs()<CR>', opts)
  --    -- Symbol renaming
  --    keyset("n", ",gn", "<Plug>(coc-rename)", opts)

  --    -- Remap <C-f> and <C-b> to scroll float windows/popups
  --    ---@diagnostic disable-next-line: redefined-local
  --    local opts = { silent = true, nowait = true, expr = true }
  --    keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
  --    keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
  --    keyset("i", "<C-f>",
  --      'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
  --    keyset("i", "<C-b>",
  --      'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
  --    keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
  --    keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

  --    -- Add `:Format` command to format current buffer
  --    vim.api.nvim_create_user_command("CocFormat", "call CocAction('format')", {})

  --    -- </from https://github.com/neoclide/coc.nvim>

  --    -- Format with Prettier
  --    -- vim.api.nvim_create_user_command("CocPrettier", "call CocAction('format')", {})
  --    vim.cmd([[ command! -nargs=0 CocPrettier :CocCommand prettier.forceFormatDocument ]])
  --  end
  --},
}
