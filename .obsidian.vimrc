"Faster <Esc> to normal mode
imap fg <Esc>
xmap fg <Esc>
imap FG <Esc>
xmap FG <Esc>

"Record with qq, play with Q
nmap Q @q

"Remap j and k intuitively
nmap j gj
xmap j gj
nmap k gk
xmap k gk
"A more intuitive bol/eol navigation
nmap H ^
xmap H ^
nmap L $
xmap L $

"Make K similar to J to join to above line
nmap K kJ
xmap gK kgJ

"Make `Y` yank to end of line (like `C` and `D`)
nmap Y y$
"Yank into clipboard
nmap gy "*y
vmap gy "*y
nmap gY "*y$
vmap gY "*y$
"Swap v and V 
nmap V v
nmap v V
"Reselect visual selection after indenting
vmap < <gv
vmap > >gv

"Quick :nohl
nmap <C-h> :nohl<CR>
xmap <C-h> :nohl<CR>
imap <C-h> <Esc>:nohl<CR>a

