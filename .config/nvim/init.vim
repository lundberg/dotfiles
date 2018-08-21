" Ensure vim-plug is installed and auto loaded
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

" Enable plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'w0rp/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/BufOnly.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'Yggdroot/indentLine'
Plug 'ervandew/supertab'
Plug 'ambv/black'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'brooth/far.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'  " Git log

Plug 'Valloric/YouCompleteMe', {'for': []}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
"Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}

"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi'  ", {'for': 'python'}
"Plug 'junegunn/fzf'

"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-ultisnips'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

Plug 'kh3phr3n/python-syntax'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'groenewege/vim-less'
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'ekalinin/Dockerfile.vim'
Plug 'mxw/vim-jsx'

" Color schemes and icons
Plug 'rakr/vim-one'
Plug 'KeitaNakamura/neodark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ryanoasis/vim-devicons'
Plug 'icymind/NeoSolarized'
Plug 'freeo/vim-kalisi'
Plug 'ayu-theme/ayu-vim'

call plug#end()


" Clipboard
let g:clipboard = {
      \   'name': 'lundberg',
      \   'copy': {
      \      '+': 'tmux load-buffer -',
      \      '*': 'tmux load-buffer -',
      \    },
      \   'paste': {
      \      '+': 'tmux save-buffer -',
      \      '*': 'tmux save-buffer -',
      \   },
      \   'cache_enabled': 1,
      \ }


" Set color scheme
"let g:dark_colorscheme='onedark'
"let g:dark_colorscheme='PaperColor'
"let g:dark_colorscheme='kalisi'
"let g:light_colorscheme='NeoSolarized'

"let g:airline_theme='onedark'
"let g:airline_theme='papercolor'
"let g:airline_theme='kalisi'
"let g:airline_theme='solarized'


" Load global vim config
source ~/.vimrc
