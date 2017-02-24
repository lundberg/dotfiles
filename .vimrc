set encoding=utf-8
set nocompatible
set clipboard=unnamed           " Share clipboard with os
set ttyfast                     " Optimization
set updatetime=250              " Optimization
set number                      " Enable line numbers
set cursorline                  " Highlight current line
set showmatch                   " Higlight matching parenthesis
set mouse=a                     " Enable mouse
set laststatus=2                " Show airline on open
set modelines=1                 " Enable file specific vim config
set splitbelow                  " Open vertical splits below
set splitright                  " Open horizontal split right
set backspace=indent,eol,start  " Normal backspace
set tags=.tags                  " Set ctags folder name
set ttimeoutlen=10              " faster leaving insert mode,
                                " makes e.g. airline snappier
filetype plugin indent on


" Syntax highlighting
syntax on
let python_highlight_all=2


" Colors
set termguicolors
set background=dark
set t_8f=[38;2;%lu;%lu;%lum  " Tmux
set t_8b=[48;2;%lu;%lu;%lum  " Tmux
set t_ut=                      " Tmux (empty background color)


" MacVim
set guioptions-=r
set guioptions-=L


" Indentation
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

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

" Python indentation
au BufNewFile,BufRead *.py set
    \ expandtab
    \ autoindent
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ fileformat=unix


" Swaps / Backups
set directory=~/.vim/swaps
set backupdir=~/.vim/backups
set backupskip=/tmp/*,/private/tmp/*
set writebackup
set backup


" Hide some UI stuff, like ~ beneath buffer
set fillchars=
highlight EndOfBuffer guifg=bg


" Leader key
let mapleader=','
let g:mapleader=','


" Search
nmap <leader>s /
nnoremap <silent> <CR> :nohlsearch<CR><CR>
set ignorecase          " ignore case when searching
set smartcase           " be case sensitive when non lowercase
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches


" Folding
set foldmethod=indent
set foldlevel=99


" Command menu tab completion
set wildmenu
set wildignorecase


" Buffer splitting
set splitright        " Open buffer on right hand split
set previewheight=20  " Used by e.g. fugitive/GStatus


" Cursor history (jumps)
nnoremap <S-l> <C-i>
nnoremap <S-h> <C-O>


" Panel movement
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l


" Buffer/panel/tab management
"nnoremap <tab> :tabnext<CR>
"nnoremap <BS> :tabprevious<CR>
nmap <silent> <tab> :bn<CR>
nmap <silent> <BS> :bp<CR>
" Expand panel
nmap + :only<CR>
" Normalize all split sizes : ALT-+
nmap = <C-W>=
" Close panel
nmap - :close<CR>
" Close buffer : ALT-w
nmap Ω :bd<CR>
nmap <bar> :vsplit<CR>
" Force close buffer : SHIFT-ALT-w
nmap ˝ :bd!<CR>


" Save : ALT+s
nmap <leader>w :w!<cr>
nmap ß :w!<cr>
" Reload file : ALT+r
nmap ® :edit!<CR>
" Quit : ALT-q
nmap • :quit<CR>
" Force quit : SHIFT-ALT-q
nmap ° :quitall!<CR>


" Location window:
" Current : ALT-l
nmap ﬁ :ll<CR>
" Previous : ALT-k
nmap ª :lprevious<CR>
" Next : ALT-j
nmap √ :lnext<CR>


" ctags
function! BuildCTags()
    echohl Comment
    echo 'Building ctags... '
    silent! exe "!ctags -R --languages=python --python-kinds=-iv -f .tags &> /dev/null"
    redraw!
    echohl String
    echo "Successfully generated ctags!"
    echohl None
endfunction

nmap <F12> :call BuildCTags()<CR>


" git
nmap <leader>gg :GitGutterToggle<CR>
"nmap <leader>gs <Plug>GitGutterStageHunk
"nmap <leader>gr <Plug>GitGutterUndoHunk
" ALT-SHIFT-k
nmap º :GitGutterPrevHunk<CR>
" ALT-SHIFT-j
nmap ¬ :GitGutterNextHunk<CR>


" CTRL-P
nmap <C-o> :CtrlPTag<CR>
nmap <C-e> :CtrlPBuffer<CR>
nmap öö :CtrlPtjump<CR>
let g:ctrlp_tjump_only_silent = 1


" Far
let g:far#window_layout = 'current'  " Open FAR in current window
let g:far#preview_window_layout = 'right'  " Show preview in right split
let g:far#file_mask_favorites = ['**/*.py', '**/*.html', '**/*.js', '**/*.css', '**/*.*', '%']
nmap <leader>f :F<space>


" NERDTree
let g:NERDCustomDelimiters = { 'cA': { 'right': '  # ' } }
let NERDTreeIgnore = ['\.pyc$']
nmap <C-n> :NERDTreeToggle<CR>
nmap <leader><lt> :NERDTreeFind<CR>


" Airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=1
let g:airline#extensions#tabline#show_tabs=1
let g:airline_powerline_fonts=1
let g:Powerline_symbols = 'unicode'
let g:airline_symbols = {}
let g:airline_symbols.space = "\ua0"
let g:airline_theme='onedark'
