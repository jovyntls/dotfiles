return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" }
    },
    config = function()
      -- setup lsp_capabilities from cmp_nvim_lsp
      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
      local default_setup = function(server)
        require('lspconfig')[server].setup({
          capabilities = lsp_capabilities,
          handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'solid' }),
          }
        })
      end

      -- setup and configure lsp servers
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { 'lua_ls', 'pyright', 'texlab', 'tsserver' },
        handlers = {
          default_setup,
          lua_ls = function() -- fix undefined global vim
            require('lspconfig').lua_ls.setup({
              capabilities = lsp_capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' },
                  },
                  workspace = {
                    library = { vim.env.VIMRUNTIME }
                  }
                },
              },
            })
          end,
        },
      }

      -- configure diagnostics
      vim.diagnostic.config({
        update_in_insert = true,
        virtual_text = false,
        float = { source = 'always', border = 'solid', max_width = 100 },
      })

      -- KEY MAPPINGS ---------------------------------------------------------
      local keyset = vim.keymap.set

      -- global mappings
      keyset('n', '[e', vim.diagnostic.goto_prev)
      keyset('n', ']e', vim.diagnostic.goto_next)
      keyset('n', '<leader>ge', vim.diagnostic.open_float)
      -- keyset('n', '<leader>gl', vim.diagnostic.setloclist)

      -- only map keys after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- buffer local mappings
          -- diagnostics list and references list are handled by trouble.nvim
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
          keyset('n', '<leader>ga', vim.lsp.buf.code_action, opts)

          -- format
          vim.keymap.set('n', '<leader>gf', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      -- AESTHETIC IMPROVEMENTS -----------------------------------------------
      -- nicer diagnostic symbols
      local sign = function(opts)
        vim.fn.sign_define(opts.name, { texthl = opts.name, text = opts.text, numhl = "" })
      end
      sign({ name = 'DiagnosticSignError', text = '✘' })
      sign({ name = 'DiagnosticSignWarn', text = '▲' })
      sign({ name = 'DiagnosticSignHint', text = '●' })
      sign({ name = 'DiagnosticSignInfo', text = '»' })
    end
  },
}
