set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'will133/vim-dirdiff'
Bundle 'edkolev/tmuxline.vim'
Plugin 'pearofducks/ansible-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'markcornick/vim-vagrant'
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'


call vundle#end()            " required
filetype plugin indent on    " required
set backspace=indent,eol,start

set showcmd
set incsearch
set number
set expandtab
set tabstop=4
set nowrap
set shiftwidth=4
set hlsearch
set ic
set autoindent
set copyindent
set cmdheight=1
set smartcase
set smarttab
set ignorecase
set incsearch
set encoding=utf-8

set history=1000
set undolevels=1000

let python_highlight_all=1
syntax on
set laststatus=2

set pastetoggle=<F2>

set noswapfile
set showmatch

set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

nnoremap ; :
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
let g:rehash256=1

let g:molokai_original=1
colorscheme molokai
let base16colorspace=256

let g:tmuxline_preset = {
      \'a'    : '%R',
      \'c'    : ['#(whoami)', '#(uptime | cud -d " " -f 1,2,3)'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%a', '%Y'],
      \'z'    : '#H'}

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
" python hacks
autocmd BufWritePre * :%s/\s\+$//e
" double escape for removing search highlights
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
" fold
nnoremap <space> za
" ycm
let g:ycm_key_list_select_completion=['<Tab>', '<Down>']
let g:ycm_key_list_previous_completion=['<S-Tab>', '<Up>']
let g:ycm_autoclose_preview_window_after_completion=1
" python pep8
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix
" html js css
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
" nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
