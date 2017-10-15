" .vimrc
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker

" Basics {
" must be first line
	set nocompatible

	scriptencoding utf-8
	setglobal fileencoding=utf-8
	set fileencodings=utf-8,ucs-bom

	" Better for vim-airline 
	set encoding=utf-8
	set termencoding=utf-8

" To fix airline-no-color problem
	set t_Co=256
" }

" Vundle Plugin Manager {
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'Shougo/neocomplcache.vim'
	Plugin 'scrooloose/nerdtree'
	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
	Plugin 'elzr/vim-json'
	Plugin 'collatzc/vim-pug'
	Plugin 'pangloss/vim-javascript'
	call vundle#end()
" }

" Settings {
	" History (default 20)
	set history=500
	" Auto detect file types
	filetype plugin indent on
	" Auto load when a file is changed from the outside
	set autoread
	set wildmenu
	" Unsaved file will hide; use :ls to show it
	set hid
	set lazyredraw
" }

" Edit {
	" Syntax highlighting
	syntax on
	" Spell checking on
	" set spell
	set ruler
	" auto enable mouse
	set mouse=a
	set mousehide
	set backspace=indent,eol,start
	set whichwrap=b,s,h,l,<,>,[,]
	" Highlight problematic white space
	set showbreak=↳\ 
	set listchars=tab:▸\ ,trail:·,extends:»,nbsp:·,eol:↲
	set list
	hi NonText ctermfg=8 guifg=gray
	hi SpecialKey ctermfg=8 guifg=gray
	set ignorecase
	set smartcase
	set hlsearch
	set magic
	set showmatch
	set mat=2
	set number
	set ffs=unix,dos,mac
	set nobackup
	set nowb
	set noswapfile
	set smarttab
	set shiftwidth=2
	set tabstop=2
	set lbr
	set tw=500
	set ai
	set si
	set wrap
	set foldlevel=0
	" For airline
	set laststatus=2
" }

" vim-airline {
	let g:Powerline_symbols="fancy"
	let g:airline_theme='dark'
	let g:airline_powerline_fonts=1
	if !exists('g:airline_symbols')
		let g:airline_symbols={}
	endif
	let g:airline#extensions#tabline#enabled=1
	let g:airline#extensions#whitespace#enabled=0
	let g:airline#extensions#whitespace#symbol='!'
" }


" neocomplcache
let g:neocomplcache_enable_at_startup=1

" NerdTree {
	if isdirectory(expand("~/.vim/bundle/nerdtree"))
		map <leader>t :NERDTreeToggle<cr>
		
	endif
" }

" Keys {
	" Fast save
	nmap <leader>w :w!<CR>

	" Change between buffers
	nnoremap <leader>n :bn<cr>
	nnoremap <leader>p :bp<cr>
	" Close buffer
	nnoremap <leader>d :bd<CR>


	" Lazy Moving
	nnoremap <C-k> :m .-2<CR>==
	nnoremap <C-j> :m .+1<CR>==
	inoremap <C-j> <ESC> :m .+1<CR>==gi
	inoremap <C-k> <ESC> :m .-2<CR>==gi
" }
