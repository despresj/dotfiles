call plug#begin('/Users/joe/dotfiles/config/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/AutoComplPop'
Plug 'morhetz/gruvbox'
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
