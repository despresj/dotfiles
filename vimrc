call plug#begin('/Users/joe/dotfiles/config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'rust-lang/rust.vim'
Plug 'https://github.com/preservim/nerdtree'
Plug 'eigenfoo/stan-vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
call plug#end()
filetype plugin indent on
nmap <F6> :NERDTreeToggle<CR>
:set number
set complete+=kspell
syntax on
call plug#end()
colorscheme gruvbox
filetype plugin indent on
let mapleader = ","
nmap <leader>ne :NERDTree<cr>
let g:SuperTabDefaultCompletionType = "context"
set ruler
set number
set nu
set hidden
set nohlsearch
set complete+=kspell
set tabstop=2
set expandtab
set smartindent
set nowrap	
set incsearch
set scrolloff=8
set relativenumber
set signcolumn=yes
set colorcolumn=80
syntax on
:au FocusLost * silent! wa

