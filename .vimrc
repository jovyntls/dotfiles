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
Plug 'puremourning/vimspector'
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
nnoremap H ^
xnoremap H ^
nnoremap L $
xnoremap L $
"Go to start/end of page
nnoremap ^ H
xnoremap ^ H
nnoremap $ L
xnoremap $ L
"Navigate between split panes
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" BUFFER MANAGEMENT ---------------------------
"Move split panes
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
"Open a terminal
nnoremap <C-T> :below term++rows=15<CR>
inoremap <C-T> <Esc>:below term++rows=15<CR>
" nnoremap <C-S-T> :vertical term++cols=50<CR>
" inoremap <C-S-T> <Esc>:vertical term++cols=50<CR>

" Open up nerdtree and a bottom terminal
function In()
  execute "below term++rows=15"
  execute "NERDTreeToggle"
  execute "wincmd l"
endfunction
command! In call In()


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
xnoremap gK kgJ

"Move lines up/down with autoindent (normal mode)
nnoremap <C-K> :<C-u>silent! move-2<CR>==
nnoremap <C-J> :<C-u>silent! move+<CR>==
"Move lines up/down with autoindent (visual mode)
xnoremap <C-K> :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <C-J> :<C-u>silent! '<,'>move'>+<CR>gv=gv

"Make `Y` yank to end of line (like `C` and `D`)
nnoremap Y y$
"Yank into clipboard
nnoremap gy "*y
vnoremap gy "*y
nnoremap gY "*y$
vnoremap gY "*y$

"Toggle fold with zf
nnoremap zf za

"Quick :nohl
nnoremap <C-H> :nohl<CR>
xnoremap <C-H> :nohl<CR>
inoremap <C-H> <Esc>:nohl<CR>a
"Quick :qa
nnoremap <C-Q> :qa<CR>
"Quick exit terminal
tnoremap <C-Q> <C-D>

" SPELLCHECK ----------------------------------------
"Toggle spellcheck on/off
nnoremap <leader>s :set invspell<CR>
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
nnoremap <C-P> :Files<CR>
xnoremap <C-P> :Files<CR>
inoremap <C-P> <Esc>:Files<CR>
"Quick Ag fuzzy find
nnoremap <C-A> :Ag<CR>
xnoremap <C-A> :Ag<CR>
inoremap <C-A> <Esc>:Ag<CR>

"NERDTree
nnoremap <C-B> :NERDTreeToggle<CR>
nnoremap <C-F> :NERDTreeFind<CR>
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

"Vimspector
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dat :call vimspector#ClearBreakpoints()<CR>
nnoremap <Leader>dT <Plug>VimspectorBreakpoints

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver

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
let g:lightline = { 'colorscheme': 'seoul256' }

"Colour scheme
colorscheme seoul256

"Make HTML tags the same colour
highlight link htmlTag htmlTagName
highlight link htmlEndTag htmlTagName

