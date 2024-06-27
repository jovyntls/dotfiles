-- Find the git root directory
local function find_git_root()
  local current_file = vim.api.nvim_buf_get_name(0)
  local cwd = vim.fn.getcwd()
  --
  -- Extract the directory from the current file's path
  local current_dir
  if current_file == '' then
    current_dir = cwd
  else
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    return cwd
  end
  return git_root
end

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

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'nerdtree',
        group = vim.api.nvim_create_augroup('NerdtreeConfig', { clear = true }),
        callback = function(ev)
          vim.keymap.set('n', '<leader>b', '<cmd>NERDTreeToggle<CR>', { buffer = true })
        end,
      })
    end
  },

  {
    'junegunn/fzf.vim',
    dependencies = 'junegunn/fzf',
    config = function()
      -- requires bat and the_silver_searcher
      vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore-dir=".git" --ignore="*.swp" -g ""'
      vim.env.BAT_THEME = 'soulburn'
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
      -- Exclude filenames from :Ag search (https://github.com/junegunn/fzf.vim/issues/346#issuecomment-655446292)
      vim.cmd(
        [[command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)]])
      -- BLinesWithPreview
      vim.cmd(
        [[command! -bang -nargs=* BLinesWithPreview call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}))
      ]]
      )

      -- Fuzzy find key maps
      vim.keymap.set('n', '<leader>f', ':Files<Space>')
      vim.keymap.set('n', '<leader>ff', ':Files ' .. find_git_root() .. '<CR>', { silent = true })
      vim.keymap.set('n', '<leader>f.', ':Files<CR>') -- search in pwd only
      vim.keymap.set('n', '<leader>fg', ':GFiles<CR>')
      vim.keymap.set('n', '<leader>fa', ':Ag<CR>')
      vim.keymap.set('n', '<leader>fb', ':Buffers<CR>')
      vim.keymap.set('n', '<leader>fs', ':BLinesWithPreview<CR>')
    end
  },

  { 'junegunn/vim-peekaboo' },

  {
    'folke/trouble.nvim',
    opts = { focus=true },
    keys = {
      { '<leader>gl', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>' },
      { '<leader>gL', '<cmd>Trouble diagnostics toggle<cr>' },
      { '<leader>gr', '<cmd>Trouble lsp_references toggle<cr>' },
    },
  }
}
