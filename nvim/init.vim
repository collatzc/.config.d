" vim-plug
"
" BELOW: needed python support
" call plug#begin()
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" call plug#end()
" 
" colorscheme base16-harmonic-dark
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
