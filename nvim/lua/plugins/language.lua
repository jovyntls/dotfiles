local js_filetypes = { 'javascript', 'javascriptreact', 'jsx', 'jsx_pretty', 'typescript', 'typescriptreact', 'tsx' }

local function table_concat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end

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

  { 'pangloss/vim-javascript',  ft = js_filetypes },
  { 'MaxMEllon/vim-jsx-pretty', ft = js_filetypes },

  {
    'neoclide/coc.nvim',
    branch = 'release',
    ft = table_concat(js_filetypes, { 'lua' }),
    cmd = 'Coc',
    config = function()
      vim.g.coc_global_extensions = {
        'coc-tsserver',
        'coc-json',
        'coc-vetur',
        'coc-lua'
      }
      
      -- <from https://github.com/neoclide/coc.nvim>
      local keyset = vim.keymap.set

      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      -- Use Tab for trigger completion with characters ahead and navigate
      local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
      keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
        opts)
      keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

      -- Make <CR> to accept selected completion item or notify coc.nvim to format
      keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

      opts = { silent = true, nowait = true }
      -- i mode: Use <c-space> to trigger completion
      keyset("i", "<c-space>", "coc#refresh()", opts)
      -- v/x mode: Applying code actions to the selected code block
      keyset("x", "<c-space>", "<Plug>(coc-codeaction-selected)", opts)
      keyset("n", "<c-space>", "<Plug>(coc-codeaction-selected)", opts)
      -- Show all diagnostics
      keyset("n", ",gl", ":<C-u>CocList diagnostics<cr>", opts)

      opts = { silent = true }
      -- Use `[e` and `]e` to navigate diagnostics
      keyset("n", "[e", "<Plug>(coc-diagnostic-prev)", opts)
      keyset("n", "]e", "<Plug>(coc-diagnostic-next)", opts)
      -- GoTo code navigation
      keyset("n", "gd", "<Plug>(coc-definition)", opts)
      keyset("n", ",gy", "<Plug>(coc-type-definition)", opts)
      keyset("n", ",gi", "<Plug>(coc-implementation)", opts)
      keyset("n", ",gr", "<Plug>(coc-references)", opts)
      -- Use K to show documentation in preview window
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end

      keyset("n", ",gk", '<CMD>lua _G.show_docs()<CR>', opts)
      -- Symbol renaming
      keyset("n", ",gn", "<Plug>(coc-rename)", opts)

      -- Remap <C-f> and <C-b> to scroll float windows/popups
      ---@diagnostic disable-next-line: redefined-local
      local opts = { silent = true, nowait = true, expr = true }
      keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
      keyset("i", "<C-f>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
      keyset("i", "<C-b>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
      keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

      -- Add `:Format` command to format current buffer
      vim.api.nvim_create_user_command("CocFormat", "call CocAction('format')", {})

      -- </from https://github.com/neoclide/coc.nvim>
    end
  },
}
