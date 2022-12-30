call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'EdenEast/nightfox.nvim'
Plug 'hachy/eva01.vim', { 'branch': 'main' }
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'racer-rust/vim-racer'
Plug 'dense-analysis/ale'
Plug 'vim-syntastic/syntastic'
Plug 'https://github.com/preservim/nerdtree'
Plug 'eigenfoo/stan-vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
call plug#end()
" theme
colorscheme terafox

set hidden
let g:racer_cmd = "/home/user/.cargo/bin/racer"

filetype plugin indent on
nmap <F6> :NERDTreeToggle<CR>
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
let g:airline#extensions#tabline#enabled = 1
set ruler
set number
set nu
set hidden
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
set autoindent
set encoding=utf-8
:au FocusLost * silent! w
autocmd FocusLost * :w
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

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
