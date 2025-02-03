" install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" plugins
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'tpope/vim-sensible'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree'
Plug 'KabbAmine/yowish.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'

call plug#end()

" disable prompt to install language server
let g:lsp_settings_enable_suggestions=0

" disable stupid annoying lsp popup
let g:lsp_signature_help_enabled = 0

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" on pressing tab, insert 4 spaces
set expandtab

" show hybrid line numbers
set number
set relativenumber

" please the eyes
colorscheme yowish
autocmd ColorScheme * highlight LineNr ctermfg=darkgrey
highlight LineNr ctermfg=darkgrey

" mouse and copy 
set mouse=a
set virtualedit+=onemore
set clipboard=unnamedplus

" remove status bar (just press ^g if you wanna see the file name)
set laststatus=2
set statusline=%F\ %{FugitiveStatusline()}

" hi StatusLine ctermbg=0 cterm=NONE
hi StatusLine ctermbg=none cterm=bold

" ctrl + <arrow-key> fix
set term=xterm

" default to not read-only for vimdiff
set noro

" *** KEYMAPS ***
nmap <C-b> :NERDTreeToggle<CR>
" join lines is so f'ing annoying get rid of it
nnoremap J <Nop>
vnoremap J <Nop>

" open with one click :)
let g:NERDTreeMouseMode=3

" show me EVERYTHING
let g:NERDTreeShowHidden=1
