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
Plug 'tpope/vim-repeat'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" disable prompt to install language server
let g:lsp_settings_enable_suggestions=0

" disable stupid annoying lsp popup
let g:lsp_signature_help_enabled = 0
let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


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
" set statusline=%F\ %{FugitiveStatusline()}
" set statusline=%F\ %{FugitiveStatusline()}\ %l:%c
set statusline=%F\ %{FugitiveStatusline()}%=%l:%c

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
nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>
nnoremap gn :LspRename<CR>
nnoremap ge :LspDocumentDiagnostics<CR>

" open with one click :)
let g:NERDTreeMouseMode=3

" show me EVERYTHING
let g:NERDTreeShowHidden=1
