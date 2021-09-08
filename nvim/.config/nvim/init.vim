" Colors
set termguicolors

" Tab and Indent settings
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

" sources .vimrc from the opened directory if it exists
set exrc

" sets full cursor instead of line cursor in insert mode
set guicursor=

" Line Number settings
set nu
set relativenumber

" Search options do not remain highlighted
set nohlsearch

" Search case settings
set smartcase
set ignorecase
set incsearch

" Allow hidden buffers
set hidden

" History management
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Scroll padding
set scrolloff=8

" Prevent long lines of code
set colorcolumn=80

" Set column for signs on left
set signcolumn=yes

" miscellaneous settings
set noerrorbells
set nowrap

" Leader
let mapleader = " "

" Plugins galore
call plug#begin('~/.vim/plugged')

" Telescope for fuzzy finding
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Colorscheme
Plug 'embark-theme/vim', { 'as': 'embark' }

" Extra syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Undoing till the start
Plug 'mbbill/undotree'

" Pretty icons
Plug 'kyazdani42/nvim-web-devicons'

" File Explorer
Plug 'preservim/nerdtree'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git Gutter
Plug 'airblade/vim-gitgutter'

" Dart/Flutter
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'

" Surround by TPOPEE
Plug 'tpope/vim-surround'

" Comments
Plug 'b3nj5m1n/kommentary'

" Fugitive, illegal plugin by TPOPEE
Plug 'tpope/vim-fugitive'

" LSP
Plug 'neovim/nvim-lspconfig'

" Emmet for Vim
Plug 'mattn/emmet-vim'

" Coc
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Javascript/React/React Native
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'yuezk/vim-js'

" Coq.nvim
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

call plug#end()

" Colorscheme
colorscheme embark

" Embark italics
let g:embark_terminal_italics = 1

" Embark Colorscheme settings
let g:embark_terminal_italics = 1

" Telescope settings
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>

" Open File Explorer
nnoremap <C-n> :NERDTreeToggle<CR>

" Airling settings
let g:airline_theme = 'embark'
let g:airline#extensions#tabline#enabled = 1

" Switch buffers remap
nnoremap <C-k> :bnext<CR>
nnoremap <C-j> :bprev<CR>
nnoremap <C-d> :bd<CR>

" Fugitive remaps
nnoremap <leader>gs :G<CR>
nnoremap <leader>gd :G diff<CR>
nnoremap <leader>gc :G commit<CR>
nnoremap <leader>gj :diffget //3<CR>
nnoremap <leader>gf :diffget //2<CR>

" Coc remaps
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" nnoremap <C-a> :CocAction<CR>

" Only run coc-prettier and coc-eslint if relevant .rc files are present in
" the folder
" if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
"   let g:coc_global_extensions += ['coc-prettier']
" endif

" if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
"   let g:coc_global_extensions += ['coc-eslint']
" endif

" Make a Prettier command to format with prettier
" command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Remove trailing whitespace autocommand
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup REMOVING_WHITESPACES
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Save folds on leaving buffer and reload them when buffer is reloaded
" augroup HANDLING_FOLDS
"   autocmd!
"   autocmd BufWinLeave . mkview!
"   autocmd BufWinEnter . silent loadview
" augroup END

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Auto source VIMRC
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $NVIMRC"

" Start syntax highlighting from the start
syntax sync fromstart
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

