set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" keep 500 lines of command line history
set history=5000
" show the cursor position all the time
set ruler
" display incomplete commands
set showcmd
" always show status line
set laststatus=2
" do incremental searching
set incsearch
" no sound bell, flash screen
set visualbell
" search case insensitive
set ignorecase
" search case insensitive unless first char is upper case
set smartcase
" indent automatically
set autoindent
" highlight search
set hlsearch
" show line numbers
set number
" no word wrap
set nowrap

set textwidth=120

set hidden

set mouse=a
" set a map leader for more key combos
let mapleader = ','
let g:mapleader = ','

""""""""""""""""""""""""""""""""""""""
" Plug
""""""""""""""""""""""""""""""""""""""
filetype off  " required

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-unimpaired'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'marijnh/tern_for_vim', {'for': 'javascript'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'flazz/vim-colorschemes'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
Plug 'rking/ag.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'chriskempson/base16-vim'
Plug 'tmhedberg/matchit'
Plug 'mxw/vim-jsx'
Plug 'Valloric/MatchTagAlways'
Plug 'Chiel92/vim-autoformat'


"""

call plug#end()
filetype plugin indent on    " required


" edit ~/.vimrc
map <leader>ev :e! ~/.vimrc<cr>


"""""""""""""""""""""""""""""""""""""""
" Theme
"""""""""""""""""""""""""""""""""""""""

" switch syntax highlighting on
syntax on
set encoding=utf8
let base16colorspace=256
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors"
colorscheme base16-chalk
set background=dark

set fillchars+=vert:\
"""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""

" nerdtree
let g:WebDevIconsNerdTreeAfterGlyphPadding =' '
" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=0
" show hidden files in NERDTree
let NERDTreeShowHidden=1
" remove some files by extension
let NERDTreeIgnore = ['\.js.map$']
" Toggle NERDTree
nmap <silent> <leader>k :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
nmap <silent> <leader>y :NERDTreeFind<cr>


" map fuzzyfinder (CtrlP) plugin
nmap <silent> <leader>t :CtrlP<cr>
nmap <silent> <leader>r :CtrlPBuffer<cr>
let g:ctrlp_map='<leader>t'
let g:ctrlp_dotfiles=1
let g:ctrlp_working_path_mode = 'ra'


" airline options
let g:airline_powerline_fonts = 1
"let g:airline_left_sep=''
"let g:airline_right_sep=''
let g:airline_theme='base16_chalk'

let g:syntastic_javascript_checkers = ['jshint', 'jscs']

" white space
highlight ExtraWhitespace ctermbg=yellow

" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>

" toggle invisible characters
"set invlist
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
highlight SpecialKey ctermbg=none " make the highlighting of tabs less annoying
set showbreak=↪
nmap <leader>l :set list!<cr>

"" Tab control
set expandtab
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=2 " the visible width of tabs
set softtabstop=2 " edit as if the tabs are 4 characters wide
set shiftwidth=2 " number of spaces to use for indent and unindent
set textwidth=0
"set shiftround " round indent to a multiple of 'shiftwidth'
"set completeopt+=longest

"panes navication
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <silent> [b :bprevious <cr>
nnoremap <silent> ]b :bnext <cr>
nnoremap <silent> [B :bfirst <cr>
nnoremap <silent> ]B :blast <cr>

" open NERDtree with no file specified
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


" close vim if NERDtree is the only buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" remap esc
inoremap jk <esc>

" tell vim to keep a backup file
set backup

" tell vim where to put its backup files
set backupdir=/private/tmp

" tell vim where to put swap files
set dir=/private/tmp

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

autocmd BufWritePre * %s/\s\+$//e
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
let g:syntastic_javascript_checkers = ['eslint']


au BufWrite * :Autoformat
