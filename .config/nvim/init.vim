" Ensure vim-plug is installed and auto loaded
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

" Enable plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'brooth/far.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"Plug 'klen/python-mode'
"Plug 'bfredl/nvim-ipy'
"Plug 'xolox/vim-easytags'
 
" Colorschemes
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ryanoasis/vim-devicons'

call plug#end()

colorscheme onedark
source ~/.vimrc
