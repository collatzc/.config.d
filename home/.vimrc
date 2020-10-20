" vim: foldmethod=marker

" Basics {{{
" must be first line
set nocompatible
set modeline
set modelines=5
set showtabline=2
set encoding=utf-8
scriptencoding utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8
set fileencodings=utf-8,ucs-bom
set visualbell
set noshowmode
if !has('gui_running')
	set t_Co=256
endif
set nobomb
" }}}

" Vundle Plugin Manager {{{
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'itchyny/lightline.vim'
Plugin 'elzr/vim-json'
Plugin 'collatzc/vim-pug'
Plugin 'pangloss/vim-javascript'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'fatih/vim-go'
Plugin 'morhetz/gruvbox'
Plugin 'arcticicestudio/nord-vim'
Plugin 'cocopon/iceberg.vim'
Plugin 'rakr/vim-one'
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-startify'
Plugin 'leafOfTree/vim-vue-plugin'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
call vundle#end()
" }}}

" Setting {{{
let mapleader=","
" History (default 20)
set history=500
" Auto detect file types
filetype on
filetype plugin on
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

" auto fcitx
let g:input_toggle = 1
function! Fcitx2en()
    let s:input_status = system("fcitx-remote")
    if s:input_status == 2
        let g:input_toggle = 1
        let l:a = system("fcitx-remote -c")
    endif
endfunction

function! Fcitx2zh()
    let s:input_status = system("fcitx-remote")
    if s:input_status != 2 && g:input_toggle == 1
        let l:a = system("fcitx-remote -o")
        let g:input_toggle = 0
    endif
endfunction

set ttimeoutlen=150
" 退出插入模式
autocmd InsertLeave * call Fcitx2en()
" 进入插入模式
autocmd InsertEnter * call Fcitx2zh()
" auto fcitx end

" coc
set hidden
set updatetime=1000
set signcolumn=yes
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

" vim-go
let g:go_gopls_enabled=1
" let g:go_debug=['lsp']
let g:go_def_mode="gopls"
let g:go_info_mode="gopls"
let g:go_fmt_command="goimports"
let g:go_term_mode="split"
let g:go_fmt_autosave=1
let g:go_term_enabled=1
let g:go_term_reuse=1
let g:go_term_close_on_exit=0
let g:go_test_show_name=1
let g:go_auto_type_info=1
let g:go_def_mapping_enabled=0
let g:go_highlight_types=1
let g:go_highlight_extra_types=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_parameters=1
let g:go_highlight_function_calls=1
let g:go_highlight_variable_declarations=1
let g:go_highlight_variable_assignments=1

" vim-vue
let g:vim_vue_plugin_use_scss=1

" vim-startify
let g:startify_session_dir="~/.vim/sessions"
let g:startify_lists=[
			\ { 'type': 'bookmarks', 	'header': ['    Bookmarks'] 	},
			\ { 'type': 'sessions', 	'header': ['    Sessions'] 		},
			\ ]
let g:startify_bookmarks=[ {'c': '~/.vimrc'}, {'z': '~/.zshrc'}, {'w': '~/.config/i3/config'}, {'a': '~/.config/alacritty/alacritty.yml'}, {'u': '~/.Xresources'} ]
let g:startify_session_autoload=1
let g:startify_session_persistence=0
let g:startify_custom_header='startify#center(startify#fortune#cowsay())'

" automatically change the current directory
"set autochdir
autocmd VimEnter * silent! cd %:p:h
" autocmd VimEnter * if argc() == 1 | cd argv()[0] | endif

" Using OS clipboard
set clipboard=unnamedplus
" enable usage of .vimrc from working dir
set exrc
" .vimrc cannot exec shell
set secure
" }}}

" Edit {{{
" Syntax highlighting
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_contrast_light='soft'
syntax on
colo nord
set background=dark " setting dark mode
" set background=light " setting light mode
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
autocmd VimEnter,InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

set ignorecase
set smartcase
set hlsearch
set magic
set showmatch
set mat=2
set nu rnu
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
set foldlevel=1
set laststatus=2
" }}}

" Lightline {{{
let g:lightline = {
			\ 'colorscheme': 'nord',
			\ 'mode_map': {
			\ 	'n': 'N',
			\ 	'i': 'I',
			\ 	'R': 'R',
			\ 	'v': 'V',
			\ 	'V': 'VL',
			\ 	"\<C-v>": 'VB',
			\ 	'c': 'C',
			\ 	's': 'S',
			\ 	'S': 'SL',
			\ 	"\<C-s>": 'SB',
			\ 	't': 'T',
			\ },
			\ 'active': {
			\ 	'left': [ [ 'mode', 'paste' ],
			\ 						[ 'gitbranch', 'readonly', 'projectpath', 'modified' ] ]
			\ }, 
			\ 'inactive': {
			\ 	'left': [ [ 'projectpath', 'modified' ] ]
			\ },
			\ 'component': {
			\ 	'lineinfo': '%3l:%-2c',
			\ },
			\ 'component_function': {
			\ 	'gitbranch': 'LightlineGitBranch',
			\ 	'projectpath': 'LightlineProjectPath',
			\ 	'readonly': 'LightlineReadonly',
			\ 	'mode': 'LightlineMode',
			\ 	'modified': 'LightlineModified',
			\ 	'filetype': 'LightlineFiletype',
			\ 	'fileformat': 'LightlineFileformat',
			\ 	'fileencoding': 'LightlineFileencoding'
			\ },
			\ 'tabline' : {
			\ 	'left': [ [ 'tabs' ] ],
			\ 	'right': []
			\ },
			\ 'separator': { 'left': '', 'right': '' },
			\ 'subseparator': { 'left': '', 'right': '' }
			\}
function! LightlineProjectPath()
	let fname = expand('%:t')
	return winwidth(0) < 50 ? '' :
				\ fname =~# '\[coc-explorer\]' ? 'Fi' :
				\ expand('%:p:h:t').'/'.expand('%:t')
endfunction
function! LightlineGitBranch()
	let branch = FugitiveHead()
	return winwidth(0) < 50 ? '' :
				\ branch != '' ? ' '.branch : ''
endfunction
function! LightlineReadonly()
	return winwidth(0) < 50 ? '' :
				\ &readonly ? '' : ''
endfunction
function! LightlineModified()
	return &ft ==# 'help' ? '' :
				\ winwidth(0) < 50 ? '' :
				\ &modified ? '+' : ''
endfunction
function! LightlineMode()
	let fname = expand('%:t')
	return fname =~# '^__Tagbar__' ? 'Tagbar' :
				\ fname =~# '\[coc-explorer\]' ? 'Fi' :
				\ lightline#mode()
endfunction
function! LightlineFiletype()
	return winwidth(0) < 50 ? '' :
				\ &filetype !=# '' ? &filetype : ''
endfunction
function! LightlineFileformat()
	return winwidth(0) < 50 ? '' : &fileformat
endfunction
function! LightlineFileencoding()
	return winwidth(0) < 50 ? '' :
				\ &fenc !=# '' ? &fenc : &enc
endfunction
" Use autocmd to force lightline update
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
" }}}

" vim-airline {{{
"let g:Powerline_symbols='fancy'
"let g:airline_theme='dark'
"let g:airline_powerline_fonts=1
"if !exists('g:airline_symbols')
"	let g:airline_symbols={}
"endif
"let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#whitespace#enabled=0
"let g:airline#extensions#whitespace#symbol='!'
" }}}

" neocomplcache {{{
let g:acp_enableAtStartup=0
let g:neocomplcache_enable_at_startup=0
let g:neocomplcache_enable_smart_case=1
" }}}

" NerdTree {{{
" if isdirectory(expand("~/.vim/bundle/nerdtree"))
	" let NERDTreeIgnore=['\.pyc$', '\.pyo', '__pycache__$', '\.git']
	" " Load only if vim is run without arguments
	" autocmd StdinReadPre * let s:std_in=1
	" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
	" nmap <leader>xd :NERDTreeToggle<cr>
	" nmap <leader>xl :NERDTreeFind<cr>
	" let g:NERDTreeQuitOnOpen=1
	" let g:NERDTreeAutoDeleteBuffer=1
	" let g:NERDTreeMinimalUI=1
	" let g:NERDTreeDirArrows=1
" endif
" }}}

" File explorer {{{
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'cd '.argv()[0] | endif
nmap <leader>xd :CocCommand explorer<cr>
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=10
" }}}

" Functions {{{
function! ClearBuf()
	let bufnrs = range(1, bufnr('$'))
	call filter(bufnrs, {_, v -> bufexists(v)})
	for bufsingle in bufnrs
		let bufsinglename = bufname(bufsingle)
		echo bufsinglename
		if empty(bufsinglename) || bufsinglename == 'NetrwTreeListing' || bufsinglename =~# '\[coc-explorer\]'
			execute 'bwipeout!' bufsingle
		endif
	endfor
endfunction
nmap <leader>bc :call ClearBuf()<cr>
autocmd VimLeavePre * call ClearBuf()
" }}}

" NERDCommenter {{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
" }}}

" Keys {{{
" Fast save
nmap <leader>w :w!<cr>
" Quit
nmap <leader>q :q<cr>

" Buffers
nnoremap <leader>bb :CocList buffers<cr>
" Change between buffers
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>
" Delete buffer
nnoremap <leader>bw :ls!<cr>:bwipeout!<space>
nnoremap <leader>bd :bwipeout!<cr>
" Rearrange the screen to open 1 win per buffer
nnoremap <leader>ba :ball<space>

" Fils
noremap <leader>xf :CocList files<cr>

" Session
nnoremap <leader>sc :SClose<cr>
nnoremap <leader>ss :SSave<space>

" Tabs
nnoremap tn :tabnew<cr>
nnoremap tc :tabclose<cr>
nnoremap tt :tabnext<cr>
nnoremap <Tab> :tabnext<cr>
nnoremap tr :tabprevious<cr>
nnoremap <S-Tab> :tabprevious<cr>
nnoremap t1 1gt
nnoremap t2 2gt
nnoremap t3 3gt
nnoremap t4 4gt
nnoremap t5 5gt
nnoremap t6 6gt
nnoremap t7 7gt
nnoremap t8 8gt
nnoremap t9 9gt
" Work directory
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" Remap keys for goto
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Formatting selected code.
xmap <leader>ff <Plug>(coc-format-selected)
nmap <leader>ff <Plug>(coc-format-selected)
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> [[ <Plug>(coc-diagnostics-prev)
nmap <silent> [] <Plug>(coc-diagnostics-next)
" Bookmarks
nmap <leader>mk <Plug>(coc-bookmark-toggle)
nmap <leader>mi <Plug>(coc-bookmark-annotate)
nmap <leader>mj <Plug>(coc-bookmark-prev)
nmap <leader>ml <Plug>(coc-bookmark-next)
nmap <leader>mu :CocCommand<space>bookmark.clearForCurrentFile<cr>
" Use to trigger completion
inoremap <silent><expr> <c-h> coc#refresh()

" fzf
nnoremap <silent> gf :Rg<cr>
nnoremap <silent> gF :GFiles<cr>
nnoremap <silent> ga :Rg<cr>
nnoremap <silent> gw :CocList windows<cr>

" Filetype go
au FileType go nmap <f6> <Plug>(go-run)
au FileType go nmap <f5> :GoTestFunc<cr>

autocmd FileType python call s:runPython()
function! s:runPython()
	imap <f5> <esc>:w<cr>:!clear;python3 %<cr>
endfunction

" Lazy Moving
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <ESC> :m .+1<CR>==gi
inoremap <C-k> <ESC> :m .-2<CR>==gi

" Terminal
nnoremap <leader>xt :13new<cr>:wincmd J<cr>:term<cr>:startinsert<cr>
" Allow hitting <Esc> to switch to normal mode
tnoremap <Esc> <C-\><C-n>
" Alt+[hjkl] to navigate through windows in insert mode
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
" Alt+[hjkl] to navigate through windows in normal mode
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>f  :<C-u>CocList grep<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Bookmark
nnoremap <silent> <space>m  :<C-u>CocList bookmark<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" }}}

" FileTypes {{{
au FileType vue setl sw=2 ts=2 sts=2 et
au FileType javascript setl sw=2 ts=2 sts=2 et
" }}}
