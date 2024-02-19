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

local sources_display = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  ultisnips = "[UltiSnips]",
  nvim_lua = "[Lua]",
}

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    {
      'quangnguyen30192/cmp-nvim-ultisnips',
      dependencies = 'sirver/ultisnips',
    },
  },
  init = function()
    local cmp = require('cmp')
    local if_cmp_visible = function(action_to_do)
      return function(fallback)
        if cmp.visible() then action_to_do() else fallback() end
      end
    end

    cmp.setup({
      sources = {
        {
          name = 'ultisnips',
          keyword_length = 2,
          keyword_pattern = [[\\\?\k\+]]
        },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
      },
      completion = {
        keyword_length = 2,
        keyword_pattern = [[\d\@!\k\k*]],
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
          vim_item.menu = (sources_display)[entry.source.name]
          vim_item.dup = 0
          return vim_item
        end
      },
    })
  end
}
