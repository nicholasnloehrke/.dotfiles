" Install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Plugins
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" Plug 'nicholasnloehrke/vim-lsp-settings', {'branch': 'robotframework-lsp'}
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

" LSP
"
" Disable prompt to install language server
let g:lsp_settings_enable_suggestions=0

" Disable stupid annoying lsp popup's
let g:lsp_signature_help_enabled = 0
let g:asyncomplete_auto_popup = 0
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_enabled = 1

" LSP highlighting
highlight clear LspWarningHighlight

" LSP tab autocomplete
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Not sure what this does
filetype plugin indent on

" Show existing tab with 4 spaces width
set tabstop=4

" Use markdown style tables
let g:table_mode_corner='|'

" When indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" Hybrid line numbers
set number
set relativenumber

" Please the eyes
set term=xterm-256color

" Not sure what this does
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set termguicolors
colorscheme catppuccin_mocha

" Mouse and copy
set mouse=a
set virtualedit+=onemore
set clipboard=unnamedplus

" Statusline
set laststatus=2
set statusline=%F\ %{FugitiveStatusline()}%=%l:%c
set shortmess+=F

" Default to not read-only for vimdiff
set noro

" Spellcheck markdown
autocmd FileType markdown setlocal spell

" Show whitespace
set list
set listchars=tab:▸\ ,trail:·,extends:>,precedes:<,nbsp:+

" Scrolloff
set scrolloff=10

" Use // instead of /* */ for c and cpp comments
autocmd FileType c,cpp setlocal commentstring=//\ %s

" Dont add a f'ing comment on enter
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Use local vimrc's (NOT SECURE)
set exrc
set secure

" Open help in vertical split
autocmd FileType help wincmd L

" Toggle NERDTree
nnoremap <C-b> :NERDTreeToggle<CR> \| <C-w>=

" Join lines is so f'ing annoying get rid of it
nnoremap J <Nop>
vnoremap J <Nop>
" Some LSP keymaps
nnoremap gd :LspDefinition<CR>
nnoremap gr :LspReferences<CR>
nnoremap gn :LspRename<CR>
nnoremap ge :LspDocumentDiagnostics<CR>
nnoremap gh :LspHover<CR>
" Center searches
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-o> <C-o>zz
nnoremap <C-i> <C-i>zz

" Open with one click
let g:NERDTreeMouseMode=3

" Show me EVERYTHING
let g:NERDTreeShowHidden=1

" Navigate soft wrapped lines a little nicer
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Use C-j and C-k for completion menu
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" fzf
nnoremap <C-p> :Buffers<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <C-f> :Files<CR>
let g:fzf_layout = { 'window': { 'width': 1, 'height': 1 } }

" Use C-q to toggle quickfix
" TODO: Figure out why the width changes when toggled in vertical splits
nnoremap <C-q> :call ToggleQuickfix()<CR>
function! ToggleQuickfix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
