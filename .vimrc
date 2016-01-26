" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/syntastic'
call plug#end()

set pastetoggle=<F2>
set ruler
set fenc=utf-8
set backspace=indent,eol,start

" leader key
let mapleader=" "

" space settings
set ts=4
set shiftwidth=4
set softtabstop=4
set expandtab

" numbering
set number
set relativenumber

" text width
set textwidth=80
set colorcolumn=81

" colors
set background=dark
set t_Co=256
"let g:solarized_termcolors=256
"http://stackoverflow.com/questions/27930003/git-commit-opens-up-two-editor-panes-instead-of-one-to-enter-message
if $_ != 'git commit'
    colorscheme solarized
endif

" status line options
set laststatus=2
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    + current column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax in square brackets
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- rodified flag in square brackets
"              +-- full path to file in the buffer
set lazyredraw

" highlight current line
autocmd WinEnter * setlocal cursorline
autocmd BufEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
setlocal cursorline

" search options
set hlsearch
set incsearch
nnoremap n nzz
nnoremap N Nzz

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" split
set splitbelow
set splitright
set winwidth=84
autocmd WinEnter * setlocal number relativenumber
autocmd WinLeave * setlocal nonumber norelativenumber

" Movement between vim windows
let g:C_Ctrl_j = 'off'
let g:BASH_Ctrl_j = 'off'
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" tab completion on files
set wildmenu
set wildmode=list:longest

"http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
" change current working directory based on file
autocmd BufEnter * silent! lcd %:p:h

" filetype options
syntax enable
filetype indent plugin on
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:tex_flavor="latex"

" CtrlP options
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(pyc)$',
    \ }
let g:ctrlp_working_path_mode='rc'
nnoremap <leader>p :CtrlP<cr>

" Syntastic options
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
nnoremap <leader>j :lnext<cr>
nnoremap <leader>k :lprevious<cr>
nnoremap <leader>e :SyntasticCheck<cr>

