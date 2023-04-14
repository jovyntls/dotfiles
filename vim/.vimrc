set nocompatible
filetype plugin indent on

call plug#begin('~/.vim/plugged')
" aesthetics
Plug 'jovyntls/seoul256.vim'
Plug 'itchyny/lightline.vim'
" git things
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'  " allow :GBrowse to open github.com
Plug 'junegunn/gv.vim'
" utilities
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'wellle/context.vim'
" editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'easymotion/vim-easymotion'
" language-specific
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips', { 'for': [ 'tex' ] }
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
" install Prettier and load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

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

"----------------------------------------------------------
" Configs for filetypes
"----------------------------------------------------------

" handle markdown and tex files differently
augroup markdownTexGroup
    autocmd!
    " spellcheck
    autocmd FileType markdown,tex,text setlocal spell
    autocmd BufRead,BufNewFile *.mdx setlocal spell
    " disable context.vim
    let g:context_enabled = 1
    " misc configs
    autocmd FileType markdown,tex,text setlocal wrap
augroup END

let g:coc_start_at_startup=0

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
"Open a terminal
nnoremap <leader>ht :below term++rows=15<CR>
nnoremap <leader>vt :vertical term++cols=50<CR>
"Move tabs
nnoremap [m :tabm -1<CR>
nnoremap ]m :tabm +1<CR>
"Yank current (absolute) filepath into system clipboard
nnoremap <leader>G :let @+ = expand("%")<CR>
"Buffer navigation
nnoremap [b :bprev<CR>
nnoremap ]b :bnext<CR>

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
nnoremap s :%s/
vnoremap s :s/
"Search for highlighted part
vnoremap * "zy<Esc>q/i\V<Esc>"zp<CR>

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
noremap <leader>y "_y
noremap <leader>Y "_y$
noremap <leader>d "_d
noremap <leader>D "_d$
noremap <leader>c "_c
noremap <leader>C "_c$

"Toggle fold with zf
nnoremap zf za

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
autocmd FileType json nnoremap <buffer> gg=G :%!python -m json.tool<CR>gg=G
"Indent visible lines on page
nnoremap Z mzH=L'z :delmark z<CR>
"Wrap all lines to 72 characters for commit messages
command Msg :set tw=72 | exe 'normal! gggqG gg"*yG :q!<CR>'

" TOGGLES -------------------------------------------
nnoremap <leader>s :set inv
nnoremap <leader>ss :set invspell<CR>
nnoremap <leader>sw :set invwrap<CR>


"----------------------------------------------------------
" Plugin mappings & configs
"----------------------------------------------------------

" fzf.vim -------------------------------------------
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
"Exclude filenames from :Ag search
"https://github.com/junegunn/fzf.vim/issues/346#issuecomment-655446292
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
"Fuzzy finds
noremap <C-F> :GFiles<CR>
inoremap <C-F> <Esc>:GFiles<CR>
noremap <C-F><C-F> :Files<CR>
inoremap <C-F><C-F> <Esc>:Files<CR>
noremap <C-F><C-G> :GFiles<CR>
inoremap <C-F><C-G> <Esc>:GFiles<CR>
noremap <C-F><C-A> :Ag<CR>
inoremap <C-F><C-A> <Esc>:Ag<CR>
noremap <C-F><C-B> :Buffers<CR>
inoremap <C-F><C-B> <Esc>:Buffers<CR>

" NERDTree ------------------------------------------
noremap <C-B> :NERDTreeToggle<CR>
noremap <leader>b :NERDTreeFind<CR>
let NERDTreeMapOpenSplit='x'
let NERDTreeMapPreviewSplit='X'
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapPreviewVSplit='V'
let NERDTreeMapPreview='O'

" fugitive.vim --------------------------------------
nnoremap ,gg :GBrowse<CR>
vnoremap ,gg :'<,'>GBrowse<CR>

" delimitMate ---------------------------------------
let delimitMate_expand_cr = 1  " add newline after expanding brackets
let delimitMate_expand_space = 1
augroup DelimitMateConfigs
	autocmd!
  au FileType tex let b:delimitMate_smart_matchpairs='^\%(\w\|\!\|[£]\|[^[:space:][:punct:]]\)'
  au FileType tex let b:delimitMate_quotes = "\" ' $"
  au FileType html,vue,md let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
  au FileType md let b:delimitMate_nesting_quotes = ['```']
augroup end


" VimTex --------------------------------------------
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" UltiSnips -----------------------------------------
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let $HOME = expand('~')
let g:UltiSnipsSnippetsDir = $HOME."~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

" lightline -----------------------------------------
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

" context.vim ---------------------------------------
let g:context_add_mappings = 0 "disable the default mappings

" coc.nvim ------------------------------------------
let g:disable_coc_filetypes = ['tex']

function! s:disable_coc_for_type()
	if index(g:disable_coc_filetypes, &filetype) == -1
    let g:coc_start_at_startup = 1
    let b:coc_enabled = 1
	endif
endfunction

augroup CocGroup
	autocmd!
	autocmd BufNew,BufEnter * call s:disable_coc_for_type()
augroup end

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><s-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<s-tab>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" i mode: Use <c-space> to trigger completion)
" v/x mode: Applying code actions to the selected code block
if has('nvim')
  xmap <c-space>  <Plug>(coc-codeaction-selected)
  nmap <c-space>  <Plug>(coc-codeaction-selected)
  inoremap <silent><expr> <c-space> coc#refresh()
else
  xmap <c-@>  <Plug>(coc-codeaction-selected)
  nmap <c-@>  <Plug>(coc-codeaction-selected)
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nnoremap <silent> ,gk :call ShowDocumentation()<CR>
nnoremap <silent> ,gn <Plug>(coc-rename)
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gr <Plug>(coc-references)

" Use `[e` and `]e` to navigate diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)


"----------------------------------------------------------
" Aesthetic improvements
"----------------------------------------------------------

"Mode Settings
let &t_SI.="\<Esc>[6 q" "SI = INSERT mode
let &t_SR.="\<Esc>[2 q" "SR = REPLACE mode
let &t_EI.="\<Esc>[2 q" "EI = NORMAL mode (ELSE)

"Colour scheme modifications
let g:seoul256_background = 235
let g:lightline.colorscheme = 'seoul256'

"Colour scheme
colorscheme seoul256

"Make HTML tags the same colour
highlight link htmlTag htmlTagName
highlight link htmlEndTag htmlTagName

