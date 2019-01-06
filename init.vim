set breakindent
set relativenumber
set number
set hidden
set incsearch
set ignorecase
set smartcase
set clipboard+=unnamedplus
syntax enable
set wildmode=full
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
let mapleader=" "
set listchars=space:.
set inccommand=split
set path+=**
set colorcolumn=80
set completeopt -=preview
set diffopt+=vertical
set autoread

" NeoBundle Scripts-----------------------------
if has('vim_starting')
    set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
    set runtimepath+=~/.config/nvim/
endif
let neobundle_readme=expand('~/.config/nvim/bundle/neobundle.vim/README.md')
if !filereadable(neobundle_readme)
    echo "Installing NeoBundle..."
    echo ""
    silent !mkdir -p ~/.config/nvim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim/
    let g:not_finsh_neobundle = "yes"
endif
call neobundle#begin(expand('$HOME/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
" ------------------------------------
" THIS IS WHERE YOUR PLUGINS WILL COME
" ------------------------------------

NeoBundle 'chriskempson/base16-vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'w0rp/ale'
NeoBundle 'autozimu/LanguageClient-neovim', {
   \ 'branch': 'next',
   \ 'do': 'bash install.sh',
   \ }
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'heavenshell/vim-jsdoc'
NeoBundle 'junegunn/gv.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'sebastianmarkow/deoplete-rust'

call neobundle#end()
filetype plugin indent on
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

"Visual settings
set cursorline
set termguicolors
set background=dark
colorscheme base16-eighties

"Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='base16_solarized'
let g:airline#extensions#ale#enabled = 1

let g:deoplete#enable_at_startup = 1

let g:deoplete#sources#rust#racer_binary='/Users/dshur/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/Users/dshur/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src'

"Ale linting
let g:ale_lint_on_text_changed = 'never'
let g:ale_fixers = ['prettier', 'eslint']
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'jsx': ['eslint']
  \}
let g:ale_lint_on_enter = 0

" Language server
let g:LanguageClient_autoStart = 1
let g:LanguageClient_changeThrottle = 2
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

let g:NERDTreeWinSize=40

" Custom function for searching
function! Rg()
  call inputsave()
  let name = input('Enter string: ')
  call inputrestore()
  call fzf#vim#grep('rg --column --line-number --glob "!*tags" --no-heading --smart-case --follow --color=always '.name, 1, 0)
endfunction


" Search for the word under the cursor
function! Rg_cursor()
  let l:str = expand('<cword>')
  call fzf#vim#grep('rg --column --line-number --glob "!*tags" --no-heading --smart-case --follow --color=always '.l:str, 1, 0)
endfunction

" Styling for filetypes
au BufNewFile,BufRead *.js call Js_file_loaded()
au BufNewFile,BufRead *.jsx call Js_file_loaded()

au BufNewFile,BufRead *.json call Json_file_loaded()
au BufNewFile,BufRead *.yaml call Json_file_loaded()
au BufNewFile,BufRead *.yml call Json_file_loaded()

au BufNewFile,BufRead *.css call Style_file_loaded()
au BufNewFile,BufRead *.less call Style_file_loaded()
au BufNewFile,BufRead *.sass call Style_file_loaded()

au Filetype make call Make_file_loaded()

function! Js_file_loaded()
  set shiftwidth=2
  set softtabstop=2
  set expandtab
endfunction


function! Json_file_loaded()
  set shiftwidth=2
  set softtabstop=2
  set expandtab
endfunction


function! Style_file_loaded()
  set shiftwidth=4
  set softtabstop=4
  set expandtab
endfunction


function! Make_file_loaded()
  set autoindent
  set noexpandtab
  set tabstop=4
  set shiftwidth=4
endfunction

"Sytnax highlighting settings
let g:jsx_ext_required = 0
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <backspace> :noh<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-W> <C-W><C-W>
nnoremap <tab> :Buffers<CR>
nnoremap <Leader>l :set list!<CR>
nnoremap <Leader>f :Files<SPACE>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>r :call Rg()<CR>
nnoremap <Leader>11 :call Rg_cursor()<CR>
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
nnoremap <Leader>l :set list!<CR>
nnoremap <silent> <leader>q :lclose<bar>b#<bar>bd #<CR>
nnoremap <Leader><Leader> :b#<CR>
nnoremap <Leader>- :foldclose<CR>
nnoremap <Leader>+ :foldopen<CR>
nnoremap <Leader><Leader> :b#<CR>
