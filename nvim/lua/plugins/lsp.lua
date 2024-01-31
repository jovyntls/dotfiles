local js_filetypes = { 'javascript', 'javascriptreact', 'jsx', 'jsx_pretty', 'typescript', 'typescriptreact', 'tsx' }

local kind_icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}

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

      vim.diagnostic.config({
        update_in_insert = true,
        virtual_text = false,
        float = { border = 'solid', source = 'always' },
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

  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  {
    'hrsh7th/nvim-cmp',
    dependencies = { {
      'quangnguyen30192/cmp-nvim-ultisnips',
      dependencies = {
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
    } },
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
          { name = 'ultisnips' },
          { name = 'nvim_lua' },
        },
        window = {
          -- [CmpPMenu] and [CmpCursorLine] defined in ui.lua
          completion = { max_width = 130, winhighlight = 'Normal:CmpPMenu,CursorLine:CmpCursorLine' },
          documentation = { border = 'solid', max_width = 130, winhighlight = 'Normal:CmpPMenu' },
        },
        enabled = function()
          -- disable in comments (but enable in cmdline mode and cursor is in a comment)
          local context = require('cmp.config.context')
          return vim.api.nvim_get_mode().mode == 'c' or not context.in_syntax_group("Comment")
        end,
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping(if_cmp_visible(cmp.select_next_item), { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(if_cmp_visible(cmp.select_prev_item), { "i", "s" }),
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { "i" }), -- keep the manual C-p and C-n
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { "i" }), -- keep the manual C-p and C-n
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
        formatting = {
          format = function(entry, vim_item)
            -- add icons for CmpItemKind (manually implement lspkind.nvim)
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            -- Source
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              ultisnips = "[UltiSnips]",
              nvim_lua = "[Lua]",
            })[entry.source.name]
            vim_item.dup = 0
            return vim_item
          end
        },
      })
    end
  },
}
