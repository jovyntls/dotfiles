return {
  {
    'preservim/nerdtree',
    cmd = 'NERDTree',
    keys = {
      { '<C-B>',     '<cmd>NERDTreeToggle<CR>', noremap = true },
      { '<leader>b', '<cmd>NERDTreeFind<CR>',   noremap = true },
    },
    init = function()
      vim.g.NERDTreeMapOpenSplit = 'x'
      vim.g.NERDTreeMapPreviewSplit = 'X'
      vim.g.NERDTreeMapOpenVSplit = 'v'
      vim.g.NERDTreeMapPreviewVSplit = 'V'
      vim.g.NERDTreeMapPreview = 'O'
    end
  },

  'junegunn/fzf',
  {
    'junegunn/fzf.vim',
    opts = {
      noremap = true,
    },
    config = function()
      -- requires bat and the_silver_searcher
      vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore="*.git*" --ignore="*.swp" -g ""'
      vim.env.BAT_THEME = 'Enki-Light' -- 'Catppuccin-mocha'
      -- change preview pane size
      vim.g.fzf_preview_window = { 'right:60%' }
      vim.g.fzf_layout = { window = { width = 0.9, height = 0.8 } }
      -- change colors
      vim.g.fzf_colors = {
        fg = { 'fg', 'Normal' },
        ['fg+'] = { 'fg', 'rubyCurlyBlockDelimiter', 'CursorColumn', 'Normal' },
        ['bg+'] = { 'fg', 'CursorLine', 'CursorColumn' },
        prompt = { 'fg', 'Function' },
        pointer = { 'fg', 'CursorColumn' }
      }

      -- Exclude filenames from :Ag search
      -- https://github.com/junegunn/fzf.vim/issues/346#issuecomment-655446292
      vim.cmd(
      [[command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)]])
      vim.cmd(
      [[command! -bang -nargs=* BLinesWithPreview call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}))
      ]]
      )
      -- Fuzzy finds
      vim.keymap.set('n', '<leader>f', ':Files<Space>')
      vim.keymap.set('n', '<leader>ff', ':Files<CR>')
      vim.keymap.set('n', '<leader>fg', ':GFiles<CR>')
      vim.keymap.set('n', '<leader>fa', ':Ag<CR>')
      vim.keymap.set('n', '<leader>fb', ':Buffers<CR>')
      vim.keymap.set('n', '<leader>fs', ':BLinesWithPreview<CR>')
    end
  },

  {
    "tversteeg/registers.nvim",
    name = "registers",
    keys = {
      { "\"",    mode = { "n", "v" } },
      { "<C-R>", mode = "i" }
    },
    cmd = "Registers",
  }
}
