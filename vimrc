call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'rust-lang/rust.vim'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'https://github.com/preservim/nerdtree'
Plug 'eigenfoo/stan-vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
call plug#end()
colorscheme gruvbox
filetype plugin indent on
nmap <F6> :NERDTreeToggle<CR>
:set number
set complete+=kspell
syntax on
call plug#end()
filetype plugin indent on
let mapleader = ","
nmap <leader>ne :NERDTree<cr>
let g:SuperTabDefaultCompletionType = "context"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
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
inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

set updatetime=300
set signcolumn=yes
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
