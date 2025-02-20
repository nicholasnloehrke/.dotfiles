"
" install vim-plug
"
"
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

"
" plugins
"
"
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'tpope/vim-sensible'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'farmergreg/vim-lastplace'

call plug#end()

"
" lsp
"
"
" disable prompt to install language server
let g:lsp_settings_enable_suggestions=0

" disable stupid annoying lsp popup
let g:lsp_signature_help_enabled = 0
let g:asyncomplete_auto_popup = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_enabled = 1

" lsp highlighting
highlight clear LspWarningHighlight

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"
" not sure
"
"
filetype plugin indent on

"
" show existing tab with 4 spaces width
"
"
set tabstop=4

"
" use markdown style tables
"
"
let g:table_mode_corner='|'

"
" when indenting with '>', use 4 spaces width
"
"
set shiftwidth=4

"
" on pressing tab, insert 4 spaces
"
"
set expandtab

"
" hybrid line numbers
"
"
set number
set relativenumber

"
" please the eyes
"
"
set term=xterm-256color

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set termguicolors
colorscheme catppuccin_mocha

"
" mouse and copy 
"
"
set mouse=a
set virtualedit+=onemore
set clipboard=unnamedplus

set laststatus=2
set statusline=%F\ %{FugitiveStatusline()}%=%l:%c
set shortmess+=F

"
" default to not read-only for vimdiff
"
"
set noro

"
" spellcheck
"
"
autocmd FileType markdown setlocal spell

"
" show whitespace
"
"
set list
set listchars=tab:▸\ ,trail:·,extends:>,precedes:<,nbsp:+


"
" just a little scrolloff
"
"
set scrolloff=10


"
" use // instead of /* */ for c and cpp comments
"
"
autocmd FileType c,cpp setlocal commentstring=//\ %s


"
" keymaps
"
"
nnoremap <C-p> :NERDTreeToggle<CR>
" join lines is so f'ing annoying get rid of it
nnoremap J <Nop>
vnoremap J <Nop>
nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>
nnoremap gn :LspRename<CR>
nnoremap ge :LspDocumentDiagnostics<CR>
nnoremap gh :LspHover<CR>
" center searches
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" open with one click :)
let g:NERDTreeMouseMode=3

" show me EVERYTHING
let g:NERDTreeShowHidden=1

" navigate soft wrapped lines a little nicer
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" use C-j and C-k for completion menu
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" fzf
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <C-f> :Files<CR>
