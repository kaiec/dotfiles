set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
" Plugin 'johngrib/vim-game-snake', {'pinned': 1}
Plugin 'suan/vim-instant-markdown'
Plugin 'vimwiki/vimwiki'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" SEE :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line




syntax on
filetype plugin indent on
set showcmd
let mapleader = ","

" Markdown support for .md files
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" NERDTree toggle
map <C-n> :NERDTreeFind<CR>
let NERDTreeQuitOnOpen=1

" vimwiki - Personal Wiki for Vim
" https://github.com/vimwiki/vimwiki
set nocompatible

" vimwiki with markdown support
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" helppage -> :h vimwiki-syntax 

" vim-instant-markdown - Instant Markdown previews from Vim
" https://github.com/suan/vim-instant-markdown
let g:instant_markdown_autostart = 0	" disable autostart
map <leader>md :InstantMarkdownPreview<CR>

" Notizen
nmap <F12> :NERDTree ~/Dropbox/Notizen<CR>
nmap <S-F12> :e ~/Dropbox/Notizen/scratch.md<CR>Go<CR>### <C-R>=strftime('%Y-%m-%d %H:%M:')<CR><Shift>
map! <C-d> <C-R>=strftime('%Y-%m-%d')<CR>

set laststatus=2

" ------------ KEY MAPPINGS ---------------------

nnoremap ö :
nnoremap Ö :
vnoremap ö :
vnoremap Ö :
" ------------ COLOR SCHEME ---------------------

" colorscheme greenwint

" ------------ LINE NUMBERS ---------------------
set number relativenumber
" https://jeffkreeftmeijer.com/vim-number/
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
highlight LineNr ctermfg=5 ctermbg=4
highlight CursorLineNr ctermfg=5 ctermbg=4

" ------------ LINE LIMIT -----------------------
set colorcolumn=81
highlight ColorColumn ctermbg=4 ctermfg=255


" ------------ Windows specific -----------------
if has("win32") || has("win64")
    set guifont=Consolas:h16:cANSI
    set background=dark
    colorscheme solarized
endif
