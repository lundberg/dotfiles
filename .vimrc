set encoding=utf-8
set nocompatible
set clipboard+=unnamedplus      " Share clipboard with os
set ttyfast                     " Optimization
set updatetime=250              " Optimization
set number                      " Enable line numbers
set cursorline                  " Highlight current line
set showmatch                   " Higlight matching parenthesis
set mouse=a                     " Enable mouse
set laststatus=2                " Show airline on open
set modelines=1                 " Enable file specific vim config
set noshowmode                  " Dont show mode, i.e. -- INSERT --
set splitbelow                  " Open vertical splits below
set splitright                  " Open horizontal split right
set diffopt=vertical            " Allways split diff vertical e.g. side by side
set backspace=indent,eol,start  " Normal backspace
set tags=.tags                  " Set ctags folder name
set ttimeoutlen=10              " faster leaving insert mode,
                                " makes e.g. airline snappier
filetype plugin indent on


" Syntax highlighting
syntax on
let python_highlight_all = 1


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
endfunction

function! g:SetColorScheme()
    " Theme specific settings
    exe 'let g:ayucolor="' . (exists('g:' . toupper(g:COLOR) . '_AYU') ? eval('g:' . toupper(g:COLOR) . '_AYU') : g:COLOR) . '"'

    exe "set background=" . g:COLOR
    exe "colorscheme " . (g:COLOR == 'dark' ? g:DARK : g:LIGHT)

    " Hide some UI stuff, like ~ beneath buffer
    set fillchars=
    highlight EndOfBuffer guifg=bg

    " Refresh dev icons in nerdtree
    if exists('g:NERDTree')
        call webdevicons#softRefresh()
    endif

    " Reload airline theme now when "remembered" g:COLOR is available
    if exists('g:' . toupper(g:COLOR) . '_AIRLINE')
        exe "AirlineTheme " . eval('g:' . toupper(g:COLOR) . '_AIRLINE')
    else
        call airline#switch_matching_theme()
    endif
endfunction

function! g:ToggleColorScheme()
    " Toggle dark vs light
    let g:COLOR = (g:COLOR == 'dark') ? 'light' : 'dark'

    call SetColorScheme()
endfunction

autocmd VimEnter * call InitColorScheme()
nmap <silent> <F2> :call ToggleColorScheme()<CR>


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
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter *.html,*.j2,*.js,*.css,*.scss,*.less setlocal tabstop=2
    autocmd BufEnter *.html,*.j2,*.js,*.css,*.scss,*.less setlocal shiftwidth=2
    autocmd BufEnter *.html,*.j2,*.js,*.css,*.scss,*.less setlocal softtabstop=2
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.yml,*.yaml setlocal tabstop=2
    autocmd BufEnter *.yml,*.yaml setlocal shiftwidth=2
    autocmd BufEnter *.yml,*.yaml setlocal softtabstop=2
augroup END


" Python
let g:python_host_prog = 'python'
let g:python3_host_prog = 'python3'
au BufNewFile,BufRead *.py set
    \ expandtab
    \ autoindent
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ fileformat=unix
    "\ textwidth=88
" Highlight 88+ columns
au BufNewFile,BufRead *.py let &colorcolumn=join(range(89,999),",")
" Breakpoint shortcut
au FileType python map <silent> <leader>b Oimport pdb; pdb.set_trace()<ESC>w:w<CR>


" Swaps / Backups
set directory=~/.vim/swaps
set backupdir=~/.vim/backups
set backupskip=/tmp/*,/private/tmp/*
set writebackup
set backup


" Help
" Follow link and jump to subject/topic
nnoremap <leader>h <C-S-]>


" Modes
" Escape faster, e.g. exit insert mode
" Ctrl-ö
map <C-\> <ESC>
nmap <silent> <C-\> <ESC>:nohlsearch<CR>
imap <C-\> <ESC>
vmap <C-\> <ESC>
cmap <C-\> <CR><ESC>


" Leader key
let mapleader=','
let g:mapleader=','


" ESC key
"nnoremap <silent> <ESC> @=(&previewwindow?':pc':':nohlsearch')<CR><CR>


" Search
nmap <leader>s /
nmap <silent> * :nohlsearch<CR>:let @/="\\<<c-r><c-w>\\>"<CR>:set hls<CR>
"nnoremap <silent> <CR> :nohlsearch<CR><CR>
set ignorecase          " ignore case when searching
set smartcase           " be case sensitive when non lowercase
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches


" Replace current word, ESC when done, hit . to repeat following matches
"nmap <leader>r *Ncgn


" Folding
set foldmethod=indent
set foldlevel=99
nnoremap <silent> <space> @=(foldlevel('.')?'za':"\<space>")<CR>


" Command menu tab completion
set wildmenu
set wildignorecase


" Completion
set completeopt=menuone,noinsert,noselect
"inoremap <silent> <C-Space>  <C-X><C-O>

" Support suggestion selection with enter key:
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
"inoremap <expr> <CR> pumvisible() ? "\<C-Y>\<ESC>a" : "\<CR>"

" Suppress the annoying 'match x of y', 'The only match' and 'Pattern not found' messages
set shortmess+=c

" Use <TAB> to select the popup menu:
let g:SuperTabDefaultCompletionType = "<c-n>"
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Buffer splitting
set splitright        " Open buffer on right hand split
set previewheight=20  " Used by e.g. fugitive/GStatus


" Cursor history (jumps)
nnoremap <S-l> <C-i>
nnoremap <S-h> <C-O>


" Add empty line above cursor in normal mode and remember position: ALT-o
nmap <silent> œ maO<ESC>`a


" Panel movement
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>


" Scroll one line up/down shortcut: ALT-k / ALT-j
nnoremap ª <C-y>
nnoremap √ <C-e>


" Buffer movement in insert mode
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <C-h> <Left>
inoremap <C-l> <Right>


" Buffer/panel/tab management
nmap <silent> <tab> :bn<CR>
nmap <silent> <BS> :bp<CR>
" Expand panel
nmap <silent> + :only<CR>
" Close all panels/buffers except current
nmap <silent> ± :BufOnly<CR>
" Normalize all split sizes : ALT-0
nmap ≈ <C-W>=
" Resize left most pane to 86 width (80 + gutter + lineno)
nmap <silent> ≠ 100<C-w>h:vertical resize 86<CR>
" Close panel
nmap <silent> - :close<CR>
" Close buffer and panel
nmap <silent> – :bd<CR>
" Close buffer : ALT-w
nmap <silent> Ω :bp \| bd #<CR>
" Force close buffer : SHIFT-ALT-w
nmap <silent> ˝ :bp \| bd! #<CR>
" Horizontal split
nmap <silent> <bar> :vsplit<CR>


" Copy / Paste
" Paste in visual mode from 0 register
vnoremap p "0p


" Save : ALT+s
nmap <silent> <leader>w :up!<CR>
nmap <silent> ß :w!<cr>
" Reload file : ALT+r
nmap <silent> ® :edit!<CR>
" Quit : ALT-q
nmap <silent> • :quit<CR>
" Force quit : SHIFT-ALT-q
nmap <silent> ° :quitall!<CR>


" Location window:
" Current : ALT-l
nmap <silent> ﬁ :ll<CR>
" Previous : ALT-k
"nmap <silent> ª :lprevious<CR>
" Next : ALT-j
"nmap <silent> √ :lnext<CR>


" ctags
function! BuildCTags()
    echohl Comment
    echo 'Building ctags... '
    silent! exe "!ctags -R -f .tags &> /dev/null"
    "silent! exe "!ctags -R --languages=python --python-kinds=-iv --exclude=.git --sort=foldcase -f .tags &> /dev/null"
    redraw!
    echohl String
    echo "Successfully generated ctags!"
    echohl None
endfunction

nmap <F12> :call BuildCTags()<CR>


" isort: ALT-i
command! -range=% Isort :<line1>,<line2>! isort -
map <silent> ı :Isort<CR>
" black: ALT-f
map <silent> ƒ :Black<CR>


" Plugins (vim-plug)
" ------------------
function! HasPlugin(name)
    return has_key(g:plugs, a:name)
endfunction


" Git (fugitive/gitgutter)
" ------------------------
nmap <silent> <leader>gu :Git up<CR>
nmap <silent> <leader>gl :GV<CR>
nmap <silent> <leader>gs :Gstatus<CR>
nmap <silent> <leader>gg :Gcommit -v<CR>
nmap <silent> <leader>ga :Gcommit --amend --no-edit<CR>
nmap <silent> <leader>gb :Gblame<CR>
nmap <silent> <leader>gd :Gdiff<CR>
nmap <silent> <leader>gp :diffput 1<CR>
nmap <silent> <leader>gc :Gread - \| up!<CR>
nmap <silent> <leader>gt :GitGutterToggle<CR>
nmap <leader>g+ <Plug>GitGutterStageHunk
nmap <leader>g- <Plug>GitGutterUndoHunk
" ALT-SHIFT-k
nmap <silent> º :GitGutterPrevHunk<CR>
" ALT-SHIFT-j
nmap <silent> ¬ :GitGutterNextHunk<CR>


" CTRL-P
" ------
nmap <silent> <C-o> :CtrlPTag<CR>
nmap <silent> <C-e> :CtrlPBuffer<CR>
nmap <silent> ÖÖ :CtrlPtjump<CR>

let g:ctrlp_tjump_only_silent = 1
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }


" FAR
" ---
"let g:far#window_layout = 'current'  " Open FAR in current window
"let g:far#preview_window_layout = 'top'  " Show preview above matches
let g:far#window_height = 11
let g:far#preview_window_height = 20
let g:far#window_min_content_width = 80
let g:far#file_mask_favorites = ['**/*.py', '**/*.html', '**/*.js', '**/*.css', '**/*.*', '%']
let g:far#source = 'agnvim'
call add(g:far#sources.agnvim.args.cmd, '--word-regexp')  " --ignore-dir

nmap <leader>f :F<space>
" Search for visual selection
vnoremap <silent> <expr> <leader>f '"0y:call PrepareFar()<CR>:F ' . @0 . ' .<CR>'
" Search for word under cursor i.e. usages
"nnoremap <silent> <expr> ää 'yiw:call PrepareFar() \| F ' . @ . ' .<CR>'
nnoremap <silent> ÄÄ :call FarWordUnderCursor()<CR>

function! FarWordUnderCursor()
    let _cword = expand("<cword>")
    let _file_mask = ' .' . expand('%:e')
    let _F = 'F ' . _cword . _file_mask

    echohl String
    echo 'Searching for "' . _cword . '"...'
    echohl None

    let _nerdtree = IsNerdTreeOpen()
    let _window_count = len(range(1, winnr('$'))) - _nerdtree
    let _window_layout = 'right'  " g:far#window_layout

    "let _ag_cmd = deepcopy(g:far#sources.agnvim.args.cmd)
    let _ignorecase = &ignorecase
    let _smartcase = &smartcase
    set noignorecase
    set nosmartcase
    "echo "pause"
    "call filter(g:far#sources.agnvim.args.cmd, 'v:val !~ "--smart-case|--ignore-case"')
    "call filter(g:far#sources.agnvim.args.cmd, 'v:val != "--smart-case"')
    "call remove(g:far#sources.agnvim.args.cmd, '--ignore-case')
    "call add(g:far#sources.agnvim.args.cmd, '--case-sensitive')
    "call add(g:far#sources.agnvim.args.cmd, '--word-regexp')
    "echo g:far#sources.agnvim.args.cmd

    if _window_count == 1
        exe _F
        "wincmd =

    elseif _window_count == 2
        3wincmd l
        let g:far#window_layout = 'current'
        silent! exe _F
        let g:far#window_layout = _window_layout
    else
        "if _nerdtree
            "NERDTreeClose
        "endif
        if _nerdtree
            silent! only | NERDTree | wincmd l
        else
            silent! only
        endif

        "vsplit

        "let g:far#window_layout = 'current'
        silent! exe _F
        "let g:far#window_layout = _window_layout
    endif

    "let g:far#sources.agnvim.args.cmd = _ag_cmd
    if _ignorecase
        set ignorecase
    endif
    if _smartcase
        set smartcase
    endif

    "vsplit

    "let g:far#window_layout = 'current'  " Open FAR in current window
    "silent! exe 'F ' . _cword . ' .'

    "let g:far#window_layout = 'right'  " Open FAR in current window
    ""wincmd =
endfunction


" NERDTree
" --------
let g:NERDCustomDelimiters = { 'cA': { 'right': '  # ' } }
let NERDTreeIgnore = ['\.pyc$']
" ALT-n
nmap <silent> <C-n> :NERDTreeToggle<CR>
nmap <silent> <leader><lt> :NERDTreeFind<CR>

function! IsNerdTreeOpen()
    return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction


" Devicons
" --------
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:DevIconsEnableFoldersOpenClose = 1


" Airline
" -------
"let g:airline#extensions#disable_rtp_load = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#ycm#enabled = 0
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
let g:airline_powerline_fonts = 1
"let g:Powerline_symbols = 'unicode'
"let g:airline_symbols = {}
"let g:airline_symbols.space = "\ua0"


" YouCompleteMe
" -------------
if HasPlugin('YouCompleteMe')
    " Defer plugin loading
    augroup load_deferred_plugins
      autocmd!
      autocmd InsertEnter * call plug#load('YouCompleteMe')
                         \| autocmd! load_deferred_plugins
    augroup END

    nmap <silent> öö :YcmCompleter GoTo<CR>
    nmap <silent> ää :YcmCompleter GoToReferences<CR>

    let g:ycm_python_binary_path = 'python'
    let g:ycm_add_preview_to_completeopt = 0
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_use_ultisnips_completer = 0   " 1
    let g:ycm_seed_identifiers_with_syntax = 0  " 1
    let g:ycm_collect_identifiers_from_tags_files = 0
    let g:ycm_enable_diagnostic_highlighting = 0
    let g:ycm_key_invoke_completion = '<C-Space>'
    let g:ycm_global_ycm_extra_conf = '~/.config/nvim/ycm_extra_conf.py'
endif


" Deoplete
" --------
if HasPlugin('deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
    inoremap <expr> <C-Space>  deoplete#mappings#manual_complete()
    set omnifunc=deoplete#mappings#manual_complete

    " Disable the candidates in Comment/String syntaxes.
    call deoplete#custom#source('_',
                \ 'disabled_syntaxes', ['Comment', 'String'])

    " set sources
    let g:deoplete#sources = {}
    let g:deoplete#sources.vim = ['vim']
    let g:deoplete#sources.python = ['jedi']
    let g:deoplete#sources.python3 = ['jedi']
    "let g:deoplete#sources.python = ['jedi', 'LanguageClient']
    "let g:deoplete#sources.python3 = ['jedi', 'LanguageClient']
    "let g:deoplete#sources.c = ['LanguageClient']
    "let g:deoplete#sources.cpp = ['LanguageClient']
    " ignored sources
    let g:deoplete#ignore_sources = {}
    let g:deoplete#ignore_sources._ = ['buffer', 'around']
endif


" NCM2 (nvim completion manager)
" ------------------------------
if HasPlugin('ncm2')
    autocmd BufEnter * call ncm2#enable_for_buffer()
    "inoremap <expr> <C-Space>  ncm2#_do_auto_trigger()
endif


" Jedi
" ----
if HasPlugin('jedi-vim')
    let g:jedi#auto_initialization = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#completions_enabled = 0
    let g:jedi#smart_auto_mappings = 0
    let g:jedi#popup_on_dot = 0
    let g:jedi#show_call_signatures = "2"  " Show on command line
    let g:jedi#show_call_signatures_delay = 0

    "let g:jedi#goto_command = "öö"  "<leader>d
    "let g:jedi#usages_command = "ää"  "<leader>n
    let g:jedi#goto_assignments_command = "<leader>g"
    "let g:jedi#goto_definitions_command = ""
    let g:jedi#documentation_command = "K"
    "let g:jedi#completions_command = "<C-Space>"
    let g:jedi#rename_command = "<leader>r"
endif


" LSP (language server client)
" ----------------------------
if HasPlugin('LanguageClient-neovim')
    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_serverCommands = {
        \ 'python': ['tcp://127.0.0.1:2087'],
        \ }
    autocmd FileType python setlocal omnifunc=LanguageClient#complete

    "set completefunc=LanguageClient#complete
    "set formatexpr=LanguageClient_textDocument_rangeFormatting()
endif


" A.L.E
" -----
"highlight clear ALEErrorSign
"highlight clear ALEWarningSign
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'  " ⚡
let g:ale_sign_column_always = 1

let g:ale_completion_enabled = 0
let g:ale_completion_delay = 10
let g:ale_completion_max_suggestions = 10
let g:ale_completion_excluded_words = ['from', 'import']

let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'scss': ['stylelint'],
\   'css': ['stylelint'],
\}
let g:ale_python_flake8_executable = 'flake8'

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'scss': ['stylelint'],
\   'css': ['stylelint'],
\}
let g:ale_javascript_eslint_executable = expand('~/.config/nvim/node_modules/.bin/eslint')
let g:ale_javascript_eslint_use_global = 0
let g:ale_scss_stylelint_executable = expand('~/.config/nvim/node_modules/.bin/stylelint')

" WIP standalone ALE language server completion:
    "let g:ale_linters = {
    "\   'python': ['flake8', 'mypyls'],
    "\}
    "let g:ale_linters_explicit = 0
    "call ale#linter#Define('python', {
    "\   'name': 'mypyls',
    "\   'lsp': 'socket',
    "\   'address_callback': {-> '127.0.0.1:2087'},
    "\   'language': 'python',
    "\   'project_root_callback': 'ale#python#FindProjectRoot',
    "\   'completion_filter': 'ale#completion#python#CompletionItemFilter',
    "\})
    "function! g:MyALECompletion()
        " WIP!
        "call ale#completion#Done()
        "call ale#completion#Queue()
        ""call ale#completion#RestoreCompletionOptions()
        "call ale#completion#GetCompletions()
        "call ale#util#FeedKeys("\<Plug>(ale_show_completion_menu)")
        "return ''
    "endfunction
    "inoremap <expr> <C-Space> MyALECompletion()


" vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key = '<C-f>'
let g:multi_cursor_next_key = '<C-f>'
let g:multi_cursor_prev_key = '<C-b>'
let g:multi_cursor_quit_key = '<C-\>'


" IndentLine
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

" auto-pairs
let g:AutoPairsMapCh = 0
