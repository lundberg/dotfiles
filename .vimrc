set encoding=utf-8
set nocompatible
set clipboard=unnamedplus       " Share clipboard with os
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
set t_8f=[38;2;%lu;%lu;%lum  " Tmux
set t_8b=[48;2;%lu;%lu;%lum  " Tmux
set t_ut=                      " Tmux (empty background color)
"set background=dark
"colorscheme desert

function! g:InitColorScheme()
    if !exists('g:COLOR')
        let g:COLOR='dark' | echo 'Setting default colors'
    endif
    if !exists('g:LIGHT')
        let g:LIGHT='delek'
    endif
    if !exists('g:DARK')
        let g:DARK='desert'
    endif

    call SetColorScheme()

    " Reload airline theme now when "remembered" g:COLOR is available
    call airline#switch_matching_theme()
endfunction

function! g:SetColorScheme()
    exe "set background=" . g:COLOR
    exe "colorscheme " . (g:COLOR == 'dark' ? g:DARK : g:LIGHT)

    " Hide some UI stuff, like ~ beneath buffer
    set fillchars=
    highlight EndOfBuffer guifg=bg

    " Refresh dev icons in nerdtree
    if exists('g:NERDTree')
        call webdevicons#softRefresh()
    endif
endfunction

function! g:ToggleColorScheme()
    " Toggle dark vs light
    let g:COLOR = (g:COLOR == 'dark') ? 'light' : 'dark'

    call SetColorScheme()
endfunction

autocmd VimEnter * call InitColorScheme()
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
au FileType python map <silent> <leader>b Oimport pdb; pdb.set_trace()<ESC>w:w<CR>


" Swaps / Backups
set directory=~/.vim/swaps
set backupdir=~/.vim/backups
set backupskip=/tmp/*,/private/tmp/*
set writebackup
set backup


" Help
" Follow link and jump to subject/topic
nnoremap <buffer> <CR> <C-]>


" Modes
" Escape faster, e.g. exit insert mode
" Ctrl-ö
map <C-\> <ESC>
imap <C-\> <ESC>
cmap <C-\> <CR><ESC>


" Leader key
let mapleader=','
let g:mapleader=','


" ESC key
nnoremap <silent> <ESC> @=(&previewwindow?':pc':':nohlsearch')<CR><CR>


" Search
nmap <leader>s /
nnoremap <silent> <CR> :nohlsearch<CR><CR>
set ignorecase          " ignore case when searching
set smartcase           " be case sensitive when non lowercase
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches

" Replace current word, ESC when done, hit . to repeat following matches
nmap <leader>r *Ncgn


" Folding
set foldmethod=indent
set foldlevel=99
nnoremap <silent> <space> @=(foldlevel('.')?'za':"\<space>")<CR>


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


" Buffer movement in insert mode
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <C-h> <Left>
inoremap <C-l> <Right>


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


" Copy / Paste
" Paste in visual mode from 0 register
vnoremap p "0p


" Save : ALT+s
nmap <silent> <leader>w :up!<CR>
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
nmap <silent> <C-n> :NERDTreeToggle<CR>
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
set completeopt=menuone  " i.e. -=preview
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" Support suggestion selection with enter key
inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<ESC>a" : "\<CR>"
