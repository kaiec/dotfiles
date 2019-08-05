set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=0
set wrapmargin=0
set expandtab
set conceallevel=0
let g:pandoc#spell#enabled = 0
let g:pandoc#syntax#conceal#use = 0
set foldlevel=1
nnoremap  <buffer> <silent> <Up>   gk
nnoremap  <buffer> <silent> <Down> gj
inoremap <expr> <buffer> <silent> <Up> pumvisible() ? '<C-P>' : '<C-O>gk'
inoremap <expr> <buffer> <silent> <Down> pumvisible() ? '<C-N>' : '<C-O>gj' 
