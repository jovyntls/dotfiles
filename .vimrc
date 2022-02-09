set nocompatible              " for YCM
filetype plugin indent on    

call plug#begin('~/.vim/plugged')
" aesthetics
Plug 'jovyntls/seoul256.vim'
Plug 'itchyny/lightline.vim'
" utilities
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
" editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'easymotion/vim-easymotion'
" language-specific
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
call plug#end()

syntax on
set number
set expandtab
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set hlsearch
set incsearch
set backspace=2  " required by delimitMate_expand_cr
set scrolloff=8
set splitright splitbelow
set nomodeline   " seldom used
set timeoutlen=300
set ttimeoutlen=100  " removes lag for lightline 
set foldmethod=indent
set nofoldenable
set foldlevelstart=10

"----------------------------------------------------
" Editing settings
"----------------------------------------------------

let mapleader = " "

"----------------------------------------------------
" Keymaps
"----------------------------------------------------

"Faster <Esc> to normal mode
inoremap fg <Esc>
xnoremap fg <Esc>
inoremap FG <Esc>
xnoremap FG <Esc>

"Record with qq, play with Q
nnoremap Q @q

"Remap j and k intuitively
nnoremap j gj
xnoremap j gj
nnoremap k gk
xnoremap k gk
"A more intuitive bol/eol navigation
nnoremap H ^
xnoremap H ^
nnoremap L $
xnoremap L $
"Go to start/end of page
nnoremap ^ H
xnoremap ^ H
nnoremap $ L
xnoremap $ L

"Make `Y` yank to end of line (like `C` and `D`)
nnoremap Y y$
"Yank into clipboard
nnoremap gy "*y
vnoremap gy "*y
nnoremap gY "*y$
vnoremap gY "*y$
"Swap v and V 
nnoremap V v
nnoremap v V
"Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

"Toggle fold with zf
nnoremap zf za

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
"Navigate between split panes
nnoremap <leader>H :wincmd H<CR>
nnoremap <leader>J :wincmd J<CR>
nnoremap <leader>K :wincmd K<CR>
nnoremap <leader>L :wincmd L<CR>
"Resize panes
nnoremap <silent> <leader>h+ :resize +5<CR>
nnoremap <silent> <leader>h- :resize -5<CR>
"Resize panes
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>

"Quick fuzzy find
nnoremap <C-F> :Files<CR>
xnoremap <C-F> :Files<CR>
inoremap <C-F> <Esc>:Files<CR>

"NERDTred
nnoremap <C-B> :NERDTreeToggle<CR>
let NERDTreeMapOpenSplit='x'
let NERDTreeMapPreviewSplit='X'
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapPreviewVSplit='V'
let NERDTreeMapPreview='O'
let NERDTreeMapCloseDir='i'
let NERDTreeMapCloseChildren='I'
"Undo an UltiSnips expansion
inoremap <silent> <C-Q> :<Esc>uua

"Format json files with gg=G
autocmd FileType json nnoremap <buffer> gg=G :%!python -m json.tool<CR>gg=G
"Indent lines on page
nnoremap K mzH=L'z :delmark z<CR>

"----------------------------------------------------
" Plugin settings
"----------------------------------------------------

"fzf.vim 
" requires bat and the_silver_searcher
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore="*.git*" --ignore="*.swp" -g ""'
let $BAT_THEME = 'Nord'
" change preview pane size
let g:fzf_preview_window = ['right:60%']
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
" change colour
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'fg+':     ['fg', 'rubyCurlyBlockDelimiter', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['fg', 'CursorLine', 'CursorColumn'],
  \ 'prompt':  ['fg', 'Function'],
  \ 'pointer': ['fg', 'CursorColumn'] }


"Delimitmate
let delimitMate_expand_cr = 1  " add newline after expanding brackets
let delimitMate_expand_space = 1

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

"----------------------------------------------------
" Aesthetic improvements
"----------------------------------------------------

"Mode Settings
let &t_SI.="\<Esc>[6 q" "SI = INSERT mode
let &t_SR.="\<Esc>[2 q" "SR = REPLACE mode
let &t_EI.="\<Esc>[2 q" "EI = NORMAL mode (ELSE)

"Lightline modifications
set noshowmode		"for lightline
set laststatus=2 	"for lightline

"Colour scheme modifications
let g:seoul256_background = 234
let g:lightline = { 'colorscheme': 'seoul256' }

"Matching Parenthesis colour
autocmd ColorScheme * highlight MatchParen ctermfg=White ctermbg=DarkBlue cterm=NONE
"Visual mode highlight colour
autocmd ColorScheme * highlight Visual ctermbg=239 ctermfg=NONE

"Colour scheme
colorscheme seoul256

"Make HTML tags the same colour
highlight link htmlTag htmlTagName
highlight link htmlEndTag htmlTagName

"Make popups background colour grey
highlight Pmenu ctermbg=239 ctermfg=NONE guibg=gray
highlight PmenuSel ctermbg=146 ctermfg=black guibg=gray

