" General keymaps

" Maintaining a .vimrc for functional editing on machines without neovim
source ~/.vimrc

" Neovim-specific ----------------------------------------------------------

" Terminal settings for nvim
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd BufWinEnter,WinEnter term://* startinsert
nnoremap <leader>vt :vsplit term://zsh<CR>
nnoremap <leader>ht :split term://zsh<CR>

