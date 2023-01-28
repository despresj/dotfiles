let mapleader = " "
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'frazrepo/vim-rainbow'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'EdenEast/nightfox.nvim'
Plug 'hachy/eva01.vim', { 'branch': 'main' }
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'racer-rust/vim-racer'
Plug 'dense-analysis/ale'
Plug 'vim-syntastic/syntastic'
Plug 'https://github.com/preservim/nerdtree'
Plug 'davidhalter/jedi-vim'
Plug 'eigenfoo/stan-vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

call plug#end()
" theme
colorscheme terafox
filetype plugin indent on
syntax on
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['pylint']
" Jedi 

" rust
let g:termdebugger="rust-gdb"
let g:SuperTabDefaultCompletionType = "context"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:racer_cmd = "/home/user/.cargo/bin/racer"
let g:airline#extensions#tabline#enabled = 1
let g:rainbow_active = 1
set hidden
set ruler
set number
set nu
set hidden
set complete+=kspell
set tabstop=2
set expandtab
set ignorecase
set smartindent
set nowrap	
set incsearch
set scrolloff=8
set relativenumber
set signcolumn=yes
set colorcolumn=80
set autoindent
set clipboard+=unnamedplus "share with systeh keyboard
set encoding=utf-8
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set updatetime=300
set signcolumn=yes

" save on lost foxus
"" autocmd FocusLost * :w
au FocusLost * if &modified | silent! wa

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" git gutter
nmap <leader>g :GitGutterLineHighlightsToggle<cr>
nmap <leader>] <Plug>(GitGutterNextHunk)
nmap <leader>[ <Plug>(GitGutterPrevHunk)

highlight GitGutterAdd    guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
"fugitive
"nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <leader>gc :Git commit -v -q<CR>

nmap <leader>ne :NERDTree<cr>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <esc><esc> :noh<return>
let g:gitgutter_highlight_linenrs = 1
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

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
