" Disable compatibility with old vi
set nocompatible

" General settings
set number              " Show line numbers
set relativenumber      " Show relative line numbers
set cursorline          " Highlight the current line
set autoindent          " Auto-indent new lines
set clipboard=unnamed   " Use system clipboard for copy/paste

" Indentation settings
set expandtab           " Use spaces instead of tabs
set smarttab            " Enable smart tab behavior
set shiftwidth=4        " Indent width
set tabstop=4           " Tab width
set ai                  " Auto-indent
set si                  " Smart indent

" Line wrapping and file reloading
set wrap                " Wrap long lines
set autoread            " Automatically reload files if changed outside Vim

" Backspace behavior
set backspace=eol,start,indent  " Make backspace behave like most editors

" Highlight matching brackets
set showmatch           " Highlight matching brackets
set mat=2               " Briefly jump to matching brackets

" Disable error bells
set noerrorbells        " Disable sound on errors
set novisualbell        " Disable visual bell on errors
set t_vb=               " Disable bell completely
set tm=500              " Timeout for mapped sequences

" Encoding and file formats
set encoding=utf8       " Set encoding to UTF-8
set ffs=unix,dos,mac    " Enable file formats for Unix, DOS, and Mac

" Backup and swap settings
set nobackup            " Disable backup files
set nowb                " Disable write backups
set noswapfile          " Disable swap files

" Enable syntax highlighting
syntax on

" Filetype detection and indentation
filetype plugin indent on

" Autocommands: Automatically set Python filetype for .py files
autocmd BufRead,BufNewFile *.py set filetype=python

" Vim-Plug configuration
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'christoomey/vim-tmux-navigator'   " Navigate between tmux and Vim
Plug 'scrooloose/nerdtree'              " File explorer plugin
Plug 'junegunn/fzf.vim'                 " Fuzzy finder
"Plug 'jpalardy/vim-slime'               " Send text to Jupyter REPL
Plug 'jiangmiao/auto-pairs'             " Auto-close brackets and quotes
"Plug 'dense-analysis/ale'               " Asynchronous linting engine

call plug#end()

" Vim-Slime configuration for Jupyter
"let g:slime_target = "jupyter"

" ALE settings
"let g:ale_linters = {
\   'python': ['pylint', 'flake8', 'mypy'],
\}
"let g:ale_lint_on_save = 1
"let g:ale_lint_on_text_changed = 'always'
"let g:ale_open_list = 1
"let g:ale_python_pylint_options = '--rcfile=~/.pylintrc'
"let g:ale_python_flake8_options = '--config=~/.flake8'
"let g:ale_python_mypy_options = '--config-file=~/.mypy.ini'



highlight LineNr ctermfg=white guifg=white
highlight CursorLineNr ctermfg=white guifg=white
