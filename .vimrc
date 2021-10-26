set nocompatible              " for YCM
filetype plugin indent on    

call plug#begin('~/.vim/plugged')
Plug 'jovyntls/seoul256.vim'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

syntax on
set number
set expandtab
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set hlsearch
set incsearch    " incremental search - highlight search results as they match
set backspace=2  " required by delimitMate_expand_cr

" Editing settings

let mapleader = " "

" Keymaps

"Make `Y` yank to end of line (like `C` and `D`)
nnoremap Y y$
"Quick :nohl
nnoremap <C-H> :nohl<CR>
xnoremap <C-H> :nohl<CR>
inoremap <C-H> <Esc>:nohl<CR>a
"Quick :qa
nnoremap <C-Q> :qa<CR>

"Move lines up/down with autoindent (normal mode)
nnoremap <C-K> :<C-u>silent! move-2<CR>==
nnoremap <C-J> :<C-u>silent! move+<CR>==
"Move lines up/down with autoindent (visual mode)
xnoremap <C-K> :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <C-J> :<C-u>silent! '<,'>move'>+<CR>gv=gv

"Navigate between split panes
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
"Resize panes
nnoremap <silent> <leader>h+ :resize +5<CR>
nnoremap <silent> <leader>h- :resize -5<CR>
"Resize panes
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

"Quick :nohl
nnoremap <C-F> :Files<CR>
xnoremap <C-F> :Files<CR>
inoremap <C-F> <Esc>:Files<CR>

"For opening NERDTree
nnoremap <C-B> :NERDTreeToggle<CR>
"Undo an UltiSnips expansion
inoremap <silent> <C-Q> :<Esc>uua

"Format json files with gg=G
autocmd FileType json nnoremap <buffer> gg=G :%!python -m json.tool<CR>gg=G
"Indent lines on page; this command is originally Ex mode
map Q mzH=L'z :delmark z<CR>

" Plugin settings

"fzf.vim 
" requires bat and the_silver_searcher
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $BAT_THEME = 'Nord'
" change preview pane size
let g:fzf_preview_window = ['right:60%']
" change colour
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'fg+':     ['fg', 'rubyCurlyBlockDelimiter', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['fg', 'CursorLine', 'CursorLine', 'CursorColumn'],
  \ 'prompt':  ['fg', 'Function'],
  \ 'pointer': ['fg', 'CursorColumn'] }


"Delimitmate
let delimitMate_expand_cr = 1  " add newline after expanding brackets

"VimTex
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

" Aesthetic improvements

"Mode Settings
let &t_SI.="\<Esc>[6 q" "SI = INSERT mode
let &t_SR.="\<Esc>[2 q" "SR = REPLACE mode
let &t_EI.="\<Esc>[2 q" "EI = NORMAL mode (ELSE)

"Colour scheme modifications
let g:seoul256_background = 234
let g:lightline = { 'colorscheme': 'seoul256' }

"Matching Parenthesis colour
autocmd ColorScheme * highlight MatchParen ctermfg=White ctermbg=DarkBlue cterm=NONE
"Visual mode highlight colour
autocmd ColorScheme * highlight Visual ctermbg=DarkGrey ctermfg=NONE

"Lightline modifications
set noshowmode		"for lightline
set laststatus=2 	"for lightline

"Colour scheme
colorscheme seoul256
