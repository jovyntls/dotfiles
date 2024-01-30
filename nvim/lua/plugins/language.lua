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
  -- { 'quangnguyen30192/cmp-nvim-ultisnips', dependencies = 'hrsh7th/nvim-cmp' },

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
      -- define lsp_capabilities from cmp_nvim_lsp
      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
      local default_setup = function(server)
        require('lspconfig')[server].setup({ capabilities = lsp_capabilities })
      end

      -- setup and configure lsp servers
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { 'lua_ls', 'pyright' },
        handlers = {
          default_setup,
          lua_ls = function()
            require('lspconfig').lua_ls.setup({
              capabilities = lsp_capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' },
                  },
                  workspace = {
                    library = {
                      vim.env.VIMRUNTIME,
                    }
                  }
                },
              },
            })
          end,
        },
      }

      local keyset = vim.keymap.set

      -- global mappings
      keyset('n', '[e', vim.diagnostic.goto_prev)
      keyset('n', ']e', vim.diagnostic.goto_next)
      keyset('n', '<leader>ge', vim.diagnostic.open_float)
      -- keyset('n', '<leader>gl', vim.diagnostic.setloclist)

      vim.diagnostic.config({ update_in_insert = true, virtual_text = false })

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

  { 'hrsh7th/cmp-nvim-lsp' },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      local if_cmp_visible = function(action_to_do)
        return function(fallback)
          if cmp.visible() then action_to_do() else fallback() end
        end
      end

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          -- don't mix with ultisnips
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping(if_cmp_visible(cmp.select_next_item), { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(if_cmp_visible(cmp.select_prev_item), { "i", "s" }),
          ['<C-b>'] = cmp.mapping(if_cmp_visible(function() cmp.scroll_docs(-4) end), { "i", "c" }),
          ['<C-f>'] = cmp.mapping(if_cmp_visible(function() cmp.scroll_docs(4) end), { "i", "c" }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-x>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
      })
    end
  },

  --{
  --  'neoclide/coc.nvim',
  --  config = function()
  --    -- <from https://github.com/neoclide/coc.nvim>
  --    local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
  --
  --    -- Show all diagnostics
  --    keyset("n", ",gl", ":<C-u>CocList --normal diagnostics<cr>", opts)
  --    -- </from https://github.com/neoclide/coc.nvim>
  --  end
  --},
}
