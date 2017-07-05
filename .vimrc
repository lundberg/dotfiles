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

if !exists('g:light_colorscheme')
    let g:light_colorscheme='delek'
endif
if !exists('g:dark_colorscheme')
    let g:dark_colorscheme='desert'
endif

function! g:SetColorScheme()
    " Set colorscheme based on background
    exe "colorscheme " . (&background == 'dark' ? g:dark_colorscheme : g:light_colorscheme)

    " Hide some UI stuff, like ~ beneath buffer
    set fillchars=
    highlight EndOfBuffer guifg=bg
endfunction

function! g:ToggleColorScheme()
    " Toggle background
    let &background = (&background == 'dark') ? 'light' : 'dark'

    call SetColorScheme()

    " Refresh dev icons in nerdtree
    if exists('g:NERDTree')
        call webdevicons#softRefresh()
    endif
endfunction

nmap <F2> :call ToggleColorScheme()<CR>


" MacVim
set guioptions-=r
set guioptions-=L


" Indentation
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.yml,*.yaml setlocal tabstop=2
    autocmd BufEnter *.yml,*.yaml setlocal shiftwidth=2
    autocmd BufEnter *.yml,*.yaml setlocal softtabstop=2
augroup END

" Python indentation etc
let g:python_host_prog = 'python'
let g:python3_host_prog = 'python3'
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




" Modes
" Escape faster, e.g. exit insert mode
" Ctrl-ö
map <C-\> <ESC>
imap <C-\> <ESC>
cmap <C-\> <C-c>


" Leader key
let mapleader=','
let g:mapleader=','


" Search
nmap <leader>s /
nnoremap <silent> <CR> :nohlsearch<CR><CR>
nnoremap <silent> <ESC> :nohlsearch<CR>
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
" Normalize all split sizes : ALT-0
nmap ≈ <C-W>=
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
let g:far#source = 'agnvim'
nmap <leader>f :F<space>


" NERDTree
let g:NERDCustomDelimiters = { 'cA': { 'right': '  # ' } }
let NERDTreeIgnore = ['\.pyc$']
nmap <C-n> :NERDTreeToggle<CR>
nmap <leader><lt> :NERDTreeFind<CR>


" Devicons
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:DevIconsEnableFoldersOpenClose = 1


" Airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=1
let g:airline#extensions#tabline#show_tabs=1
let g:airline_powerline_fonts=1
let g:Powerline_symbols = 'unicode'
let g:airline_symbols = {}
let g:airline_symbols.space = "\ua0"


" YouCompleteMe
let g:ycm_python_binary_path = 'python'


" Last but not least, set the color scheme
call SetColorScheme()
