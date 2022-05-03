source ~/.vimrc

autocmd TermOpen * setlocal nonumber norelativenumber
autocmd BufWinEnter,WinEnter term://* startinsert

nnoremap <leader>vt :vsplit term://zsh
nnoremap <leader>ht :split term://zsh
