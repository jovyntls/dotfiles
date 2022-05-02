set nocompatible

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
" install Prettier and load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
call plug#end()

syntax on
set number
set expandtab
set smartindent
set tabstop=2
set shiftwidth=2
set backspace=2  " required by delimitMate_expand_cr
set scrolloff=8
set splitright splitbelow
set nomodeline   " seldom used
set timeoutlen=300
set ttimeoutlen=100  " removes lag for lightline 
set foldmethod=indent
set nofoldenable
set foldlevelstart=10
set complete=.,w,b,u,t " remove i, which causes vimtex to search in usr/.../texlive

"----------------------------------------------------------
" Misc configs that are important
"----------------------------------------------------------

augroup markdownTexSpell
    autocmd!
    autocmd FileType markdown,tex,text setlocal spell
    autocmd BufRead,BufNewFile *.mdx setlocal spell
augroup END

"----------------------------------------------------------
" Editing settings
"----------------------------------------------------------

let mapleader = " "
nnoremap <leader>s :set inv

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
"Navigate between split panes
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
"Navigate between tabs
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap [T :tabfirst<CR>
nnoremap ]T :tablast<CR>

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
"Open a terminal
nnoremap <leader>gt :below term++rows=15<CR>
nnoremap <leader>t :vertical term++cols=50<CR>


" SELECTION -----------------------------------------
"Swap v and V 
nnoremap V v
nnoremap v V
"Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" EDITING -------------------------------------------
"Record with qq, play with Q
nnoremap Q @q

"Make K similar to J to join to above line
nnoremap K kJ
nnoremap gK kgJ

"Move lines up/down with autoindent (normal mode)
nnoremap <C-K> :<C-u>silent! move-2<CR>==
nnoremap <C-J> :<C-u>silent! move+<CR>==
"Move lines up/down with autoindent (visual mode)
xnoremap <C-K> :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <C-J> :<C-u>silent! '<,'>move'>+<CR>gv=gv

"Yank into clipboard
nnoremap gy "*y
vnoremap gy "*y
nnoremap gY "*y$
vnoremap gY "*y$
"Black hole registers
noremap <leader>y "_y
noremap <leader>Y "_y$
noremap <leader>d "_d
noremap <leader>D "_d$
noremap <leader>c "_c
noremap <leader>C "_c$

"Toggle fold with zf
nnoremap zf za

"Quick :nohl
nnoremap <C-H> :nohl<CR>
xnoremap <C-H> :nohl<CR>
inoremap <C-H> <Esc>:nohl<CR>a
"Quick :qa
noremap <C-Q> :qa<CR>

" IMPROVED TERMINAL ---------------------------------
"Quick exit terminal
tnoremap <C-Q> <C-D>
"Toggle normal mode on the terminal
tnoremap <C-N> <C-\><C-N>

" SPELLCHECK ----------------------------------------
"Toggle spellcheck on/off
nnoremap <leader>ss :set invspell<CR>
"Swap internal wordlist and spellfile
nnoremap zg zG
nnoremap zG zg
nnoremap zw zW
nnoremap zW zw
"Autocorrect the last bad word
inoremap <C-L> <c-g>u<Esc>[s1z=`]a<c-g>u
"Cycle through words if C-L doesn't give the right correction
inoremap <C-S> <Esc>uea<C-X><C-S>
""<Esc>[sz=1<CR>

" FORMATTING ----------------------------------------
"Format json files with gg=G
autocmd FileType json nnoremap <buffer> gg=G :%!python -m json.tool<CR>gg=G
"Indent visible lines on page
nnoremap Z mzH=L'z :delmark z<CR>
"Wrap all lines to 72 characters for commit messages
command Msg :set tw=72 | exe 'normal! gggqG gg"*yG :q!<CR>'

"----------------------------------------------------------
" Plugin mappings
"----------------------------------------------------------

"Quick fuzzy find
noremap <C-F> :Files<CR>
inoremap <C-F> <Esc>:Files<CR>
"Quick Ag fuzzy find
noremap <C-A> :Ag<CR>
inoremap <C-A> <Esc>:Ag<CR>

"NERDTree
noremap <C-B> :NERDTreeToggle<CR>
let NERDTreeMapOpenSplit='x'
let NERDTreeMapPreviewSplit='X'
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapPreviewVSplit='V'
let NERDTreeMapPreview='O'
let NERDTreeMapCloseDir='i'
let NERDTreeMapCloseChildren='I'

"----------------------------------------------------------
" Plugin settings
"----------------------------------------------------------

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
au FileType tex let b:delimitMate_quotes = "\" ' $"
au FileType html,vue,md let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
au FileType md let b:delimitMate_nesting_quotes = ['```']

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

"Lightline
let g:lightline = {}
let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'readonly', 'filename', 'modified' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'filetype' ] ] }
let g:lightline.inactive = { 
      \ 'left': [ [ 'filename' ] ],
      \ 'right': [],
      \ }

"----------------------------------------------------------
" Aesthetic improvements
"----------------------------------------------------------

"Mode Settings
let &t_SI.="\<Esc>[6 q" "SI = INSERT mode
let &t_SR.="\<Esc>[2 q" "SR = REPLACE mode
let &t_EI.="\<Esc>[2 q" "EI = NORMAL mode (ELSE)

"Lightline modifications
set noshowmode		"for lightline
set laststatus=2 	"for lightline

"Colour scheme modifications
let g:seoul256_background = 234
let g:lightline.colorscheme = 'seoul256'

"Colour scheme
colorscheme seoul256

"Make HTML tags the same colour
highlight link htmlTag htmlTagName
highlight link htmlEndTag htmlTagName

