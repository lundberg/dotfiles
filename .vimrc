" Colors
syntax enable           " enable syntax processing
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

" Misc
set ttyfast                     " faster redraw
set backspace=indent,eol,start
set nocompatible
set clipboard=unnamed

" Spaces & Tabs
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
set modelines=1
filetype indent on
filetype plugin on
set autoindent

" UI Layout
set number              " show line numbers
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set wildmenu
set showmatch           " higlight matching parenthesis
set cursorline          " highlight the current line

" Searching
set ignorecase          " ignore case when searching
set smartcase           " be case sensitive when non lowercase
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches

" Line Shortcuts
nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $

" Misc shortcuts
" Allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %
" Move between panes with ctrl+jkhl
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" MacVim
set guioptions-=r
set guioptions-=L

" AutoGroups
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
		autocmd BufEnter *.yaml setlocal tabstop=2
    autocmd BufEnter *.yaml setlocal shiftwidth=2
    autocmd BufEnter *.yaml setlocal softtabstop=2
augroup END

" Backups
set backup
set backupdir=~/.vim/backups
set backupskip=/tmp/*,/private/tmp/*
set writebackup

" Swap & Undo
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif
