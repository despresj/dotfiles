call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'rust-lang/rust.vim'
Plug 'https://github.com/preservim/nerdtree'
Plug 'eigenfoo/stan-vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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

