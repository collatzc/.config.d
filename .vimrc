" .vimrc
" vim: set fdm=marker foldmarker={,}:
" Basics {
" must be first line
	set nocompatible

	set encoding=utf-8
	scriptencoding utf-8
	set termencoding=utf-8
	setglobal fileencoding=utf-8
	set fileencodings=utf-8,ucs-bom

" To fix airline-no-color problem
	set t_Co=256
	set nobomb
" }

" Vundle Plugin Manager {
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'Shougo/neocomplcache.vim'
	Plugin 'scrooloose/nerdtree'
	Plugin 'scrooloose/nerdcommenter'
	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
	Plugin 'elzr/vim-json'
	Plugin 'collatzc/vim-pug'
	Plugin 'pangloss/vim-javascript'
	call vundle#end()
" }

" Settings {
	let mapleader=","
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
	" 默認不使用輸入法
	set iminsert=0
	set imsearch=0
	" Using OS clipboard
	set clipboard^=unnamed
" }

" Edit {
	" Syntax highlighting
	syntax on
	" Spell checking on
	" set spell
	set ruler
	" auto enable mouse
	set mouse=r
	set mousehide
	set backspace=indent,eol,start
	set whichwrap=b,s,h,l,<,>,[,]
	" Highlight problematic white space
	set showbreak=↪\ 
	set listchars=tab:▸\ ,trail:·,extends:»,nbsp:·,eol:↲
	set list
	hi NonText ctermfg=8 guifg=gray
	hi SpecialKey ctermfg=8 guifg=gray
	"智能當前行高亮
	autocmd InsertLeave,WinEnter * set cursorline
	autocmd InsertEnter,WinLeave * set nocursorline
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
	set foldenable
	set foldmethod=indent
	set foldlevel=0
	" For airline
	set laststatus=2
" }

" vim-airline {
	let g:Powerline_symbols='fancy'
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
		let NERDTreeIgnore=['\.pyc$', '\.pyo', '__pycache__$']
		" Load only if vim is run without arguments
		autocmd VimEnter * if !argc() | NERDTree | endif
		nmap <leader>b :NERDTreeToggle<cr>
		
	endif
" }

" NERDCommenter {
	let g:NERDSpaceDelims = 1
	let g:NERDCompactSexyComs = 1
	let g:NERDDefaultAlign = 'left'
	let g:NERDCommentEmptyLines = 1
	let g:NERDTrimTrailingWhitespace = 1
" }

" Keys {
	" Fast save
	nmap <leader>w :w!<cr>
	nmap <leader>s :wq<cr>
	" Quit
	nmap <leader>q :q<cr>
	" Change between buffers
	nnoremap <leader>n :bn<cr>
	nnoremap <leader>p :bp<cr>
	" Close buffer
	nnoremap <leader>d :bd<cr>
	" Tabs
	nnoremap <leader>t :tabnew<cr>
	nnoremap <leader>c :tabclose<cr>


	" Lazy Moving
	nnoremap <C-k> :m .-2<CR>==
	nnoremap <C-j> :m .+1<CR>==
	inoremap <C-j> <ESC> :m .+1<CR>==gi
	inoremap <C-k> <ESC> :m .-2<CR>==gi
" }
