" General keymaps

let mapleader = " "

" <NEOVIM-ONLY> ------------------------------------------------------------

" Disable mouse
set mouse=

" Terminal settings for nvim
autocmd TermOpen * setlocal nonumber norelativenumber
autocmd BufWinEnter,WinEnter term://* startinsert
nnoremap <leader>tv :50 vsplit term://zsh<CR>
nnoremap <leader>th :15 split term://zsh<CR>

" </NEOVIM-ONLY> -----------------------------------------------------------

set nocompatible
filetype plugin indent on

syntax on
set autoindent
set autoread
set expandtab
set tabstop=2 shiftwidth=2
set hlsearch incsearch
set number
set nowrap
set scrolloff=8
set splitright splitbelow
set timeoutlen=300
set ttimeoutlen=100     " removes lag for lightline 
set foldmethod=indent
set nofoldenable
set foldlevelstart=10
set backup backupdir=~/.vim/backups
set nomodeline          " seldom used
set backspace=2         " required by delimitMate_expand_cr
set complete=.,w,b,u,t  " remove i, which causes vimtex to search in usr/.../texlive
set noshowmode		      " for lightline
set laststatus=2		    " for lightline + vim
set formatoptions+=j
set spelllang=en_gb
set nospell             " stop spell turning on for everything

" handle markdown and tex files differently
augroup markdownTexGroup
    autocmd!
    " spellcheck
    autocmd FileType markdown,tex,text setlocal spell
    autocmd BufRead,BufNewFile *.mdx setlocal spell
    " line breaks
    autocmd FileType markdown,tex,text setlocal wrap
    autocmd FileType markdown,tex setlocal linebreak
augroup END

" detect ANTLR
augroup detectANTLR
  autocmd BufRead,BufNewFile *.g4 set filetype=antlr4
augroup END

"----------------------------------------------------------
" Keymaps
"----------------------------------------------------------

" MODES ---------------------------------------------
"Enter command line mode faster
nnoremap ; :
xnoremap ; :
"Faster <Esc> to normal mode
inoremap fg <Esc>
xnoremap fg <Esc>
inoremap FG <Esc>
xnoremap FG <Esc>

" NAVIGATION ----------------------------------------
"Moving in insert mode
inoremap <C-B> <left>
inoremap <C-F> <right>
"Remap j and k intuitively
nnoremap j gj
xnoremap j gj
nnoremap k gk
xnoremap k gk
nnoremap gj j
xnoremap gj j
nnoremap gk k
xnoremap gk k
"A more intuitive bol/eol navigation
noremap H ^
noremap L $
"Go to start/end of page
noremap ^ H
noremap $ L
" Move the view horizontally when nowrap is set
nnoremap zl 10zl
nnoremap zh 10zh
"Navigate between split panes
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
"Navigate between tabs
nnoremap <silent> [t :tabprevious<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [T :tabfirst<CR>
nnoremap <silent> ]T :tablast<CR>

" BUFFER MANAGEMENT ---------------------------
"Move split panes
nnoremap <leader>H :wincmd H<CR>
nnoremap <leader>J :wincmd J<CR>
nnoremap <leader>K :wincmd K<CR>
nnoremap <leader>L :wincmd L<CR>
"Resize panes
nnoremap <silent> <S-Up> :resize +5<CR>
nnoremap <silent> <S-Down> :resize -5<CR>
"Resize panes
nnoremap <silent> <S-Right> :vertical resize +5<CR>
nnoremap <silent> <S-Left> :vertical resize -5<CR>
"Move tabs
nnoremap [m :tabm -1<CR>
nnoremap ]m :tabm +1<CR>
"Yank current (absolute) filepath into system clipboard
nnoremap <leader>G :let @+ = expand("%")<CR>
"Buffer navigation
nnoremap [b :bprev<CR>
nnoremap ]b :bnext<CR>
nnoremap <leader><tab> <C-^>

" SELECTION -----------------------------------------
"Swap v and V 
nnoremap V v
nnoremap v V
"Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" EDITING -------------------------------------------
"Easier delete
inoremap <S-BS> <Del>

"Record with qq, play with Q
nnoremap Q @q
"apply on every line selected
vnoremap Q :normal @q<CR> 

"Search utilities
nnoremap g/ /\c
"Search for highlighted part
vnoremap * "zy<Esc>/\V<C-R>z<CR>

"Make K similar to J to join to above line
nnoremap K kJ
nnoremap gK kgJ

"Move lines up/down with autoindent
nnoremap <C-K> :<C-u>silent! move-2<CR>==
nnoremap <C-J> :<C-u>silent! move+<CR>==
xnoremap <C-K> :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <C-J> :<C-u>silent! '<,'>move'>+<CR>gv=gv

"Open blank line above/below
nnoremap <CR> o<Esc>
nnoremap <S-CR> O<Esc>

"Make `Y` yank to end of line (like `C` and `D`)
noremap Y y$
"Yank into clipboard
nnoremap gy "*y
vnoremap gy "*y
nnoremap gY "*y$
vnoremap gY "*y$
"Black hole registers
noremap <leader>d "_d
noremap <leader>D "_d$
noremap <leader>c "_c
noremap <leader>C "_c$
vnoremap <leader>p "_dP

"Toggle fold with zf
nnoremap zf za
nnoremap za zf

"Quick :nohl
nnoremap <silent> <C-H> :nohl<CR>
xnoremap <silent> <C-H> :nohl<CR>
inoremap <silent> <C-H> <Esc>:nohl<CR>a
"Quick :qa
noremap <C-Q> :qa<CR>

" IMPROVED TERMINAL ---------------------------------
"Quick exit terminal
tnoremap <C-Q> <C-D>
"Toggle normal mode on the terminal
tnoremap <C-N> <C-\><C-N>

" IMPROVED COMMANDLINE ------------------------------
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" SPELLCHECK ----------------------------------------
"Swap internal wordlist and spellfile
nnoremap zg zG
nnoremap zG zg
nnoremap zw zW
nnoremap zW zw
"Autocorrect the last bad word
inoremap <C-L> <c-g>u<Esc>[s1z=`]a<c-g>u
"Cycle through words if C-L doesn't give the right correction
inoremap <C-S> <Esc>uea<C-X><C-S>

" FORMATTING ----------------------------------------
"Format json files with gg=G
autocmd FileType json nnoremap <buffer> gg=G :%!python3 -m json.tool<CR>gg=G
"Indent visible lines on page
nnoremap Z mzH=L'z :delmark z<CR>
"Wrap all lines to 72 characters for commit messages
command Msg :set tw=72 | exe 'normal! gggqG gg"*yG :q!<CR>'

" TOGGLES -------------------------------------------
nnoremap <leader>s :set inv
nnoremap <leader>ss :set invspell<CR>
nnoremap <leader>sw :set invwrap<CR>
nnoremap <leader>sl :set invlinebreak<CR>

"Mode Settings
let &t_SI.="\<Esc>[6 q" "SI = INSERT mode
let &t_SR.="\<Esc>[2 q" "SR = REPLACE mode
let &t_EI.="\<Esc>[2 q" "EI = NORMAL mode (ELSE)

"Make HTML tags the same colour
highlight link htmlTag htmlTagName
highlight link htmlEndTag htmlTagName

