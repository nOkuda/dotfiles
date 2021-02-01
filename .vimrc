" force improved
set nocompatible

" leader key
let mapleader=" "

" faster plugin loading?
filetype off

" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" :PlugInstall
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'cohama/lexima.vim'
Plug 'JuliaLang/julia-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'
Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'pangloss/vim-javascript'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'dhruvasagar/vim-table-mode'
Plug 'Konfekt/FastFold'
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'lervag/wiki.vim'
call plug#end()

runtime macros/matchit.vim

" prevent mouse interference
set mouse=

" Various settings
set pastetoggle=<F2>
set ruler
set fenc=utf-8
set backspace=indent,eol,start
set title
set scrolloff=2
set ttyfast

" escape key alternative
inoremap <C-c> <Esc>

" space settings
set ts=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
"set cinoptions=(0,N-s
set list listchars=tab:»\ ,trail:·,nbsp:·
autocmd FileType html,javascript,json,markdown,scala,xml setlocal shiftwidth=2 tabstop=2 softtabstop=2

" numbering
set number
set relativenumber

" text width
set textwidth=79
set colorcolumn=80

" colors
set background=light
set termguicolors
" https://www.reddit.com/r/vim/comments/5416d0/true_colors_in_vim_under_tmux/
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"http://stackoverflow.com/questions/27930003/git-commit-opens-up-two-editor-panes-instead-of-one-to-enter-message
if $_ != 'git commit'
    "https://github.com/morhetz/gruvbox/issues/175
    let g:gruvbox_guisp_fallback = "bg"
    "https://github.com/gruvbox-community/gruvbox/issues/126
    let g:gruvbox_invert_selection = 0
    colorscheme gruvbox
endif

" force vim to respond immediately to escape
set timeoutlen=1000 ttimeoutlen=0

" for best results, install https://github.com/powerline/fonts/Hack to ~/.fonts
" then run fc-cache -vf ~/.fonts

" highlight current line
autocmd WinEnter * setlocal cursorline
autocmd BufEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
setlocal cursorline

" search options
set hlsearch
set incsearch
" when jumping to next or previous search result, center the result on screen
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
  if expand('%:t') == "COMMIT_EDITMSG"
    return 1
  endif
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
if has('nvim')
    nmap <BS> <C-W>h
endif
nnoremap <C-l> <C-w>l

" tab completion on files
set wildmenu
set wildmode=list:longest

"http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
" change current working directory based on file
autocmd BufEnter * silent! lcd %:p:h

" filetype options
syntax enable
filetype on
filetype indent on
filetype plugin on
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType markdown setlocal foldlevel=99 textwidth=0 spelllang=en_us
let g:markdown_folding=1
nnoremap <leader>s :set spell!<CR>
" in insert mode on a markdown file, insert parenthesized timestamp
" https://stackoverflow.com/a/58604
" https://vi.stackexchange.com/a/10666
autocmd FileType markdown inoremap <buffer> <C-D> (<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>)
autocmd FileType plaintex,tex,latex setlocal spell spelllang=en_us
autocmd FileType text setlocal textwidth=0
let g:tex_flavor="latex"
let g:tex_indent_brace=0
autocmd FileType cpp setlocal matchpairs+=<:>

" lexima options
" let g:lexima_enable_newline_rules=0
call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'latex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'latex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'latex'})
call lexima#add_rule({'char': "'", 'at': 'f\%#', 'input_after': "'", 'filetype': 'python'})

" ALE options
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!'
nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <leader>e :ALELint<cr>
let g:ale_lint_on_text_changed = 'never'
" in case I want to configure airline with ALE's status line:
" https://github.com/w0rp/ale/issues/199
let g:ale_statusline_format = ['✗ %d', '! %d', '⬥ ok']
let g:ale_echo_msg_error_str = '✗'
let g:ale_echo_msg_warning_str = '!'
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
" need to install pyls ahead of time with
" pip3 install --user 'python-language-server[all]'
let g:ale_linters = {
\   'python': ['pyls'],
\   'cpp': ['clang'],
\   'rust': ['analyzer'],
\}
let g:ale_fixers = {
\   'python': ['remove_trailing_lines', 'isort', 'yapf',]
\}
let g:ale_fix_on_save = 1
nmap <silent> <leader>f :ALEFix<CR>
let g:ale_cpp_clang_executable = 'clang++-5.0'
let g:ale_cpp_clang_options = '-std=c++1z -Wall `pkg-config --libs --cflags icu-uc icu-io` -I${HOME}/Code/cereal/include -I${HOME}/Code/compare-tess/cpp/include'
" Remap keybindings to find function definitions with LSP
" https://github.com/dense-analysis/ale/issues/1645
function ALELSPMappings()
	let l:lsp_found=0
	for l:linter in ale#linter#Get(&filetype) | if !empty(l:linter.lsp) | let l:lsp_found=1 | endif | endfor
	if (l:lsp_found)
		nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>
		nnoremap <buffer> <C-^> :ALEFindReferences<CR>
	else
		silent! unmap <buffer> <C-]>
		silent! unmap <buffer> <C-^>
	endif
endfunction
autocmd BufRead,FileType * call ALELSPMappings()

" status line (airline) options
set laststatus=2
let g:airline_theme='base16'
let g:airline_powerline_fonts = 1
" vim-airline/autoload/airline/extensions/ale.vim
let g:airline#extensions#ale#error_symbol = '✗:'
let g:airline#extensions#ale#warning_symbol = '!:'

" UltiSnips options
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" commenting options
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
" can't use noremap for some reason
map <leader>; <plug>NERDCommenterToggle

nnoremap <leader>m :!make<cr>

let g:table_mode_corner='|'

" Define denite mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> ;
  \ denite#do_map('toggle_select').'j'
endfunction

" http://enigmatrix.me/blog/2019/06/12/my-vim-setup/
call denite#custom#var('file/rec', 'command',
	\ ['rg', '--files', '--glob', '!.git', '--color', 'never'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts', ['--smart-case', '--follow', '--hidden', '--vimgrep', '--heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'auto_resize': 1,
\ 'direction': 'rightbelow',
\ 'winminheight': '10',
\ 'highlight_mode_insert': 'Visual',
\ 'highlight_mode_normal': 'Visual',
\ 'prompt_highlight': 'Function',
\ 'highlight_matched_char': 'Function',
\ 'highlight_matched_range': 'Normal'
\ }}
" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)

call denite#custom#option('_', 'statusline', v:false)

nnoremap <leader>p :DeniteProjectDir file/rec -start-filter grep:::!<CR>
nnoremap <leader>b :Denite buffer<CR>
nnoremap <leader>/ :Denite line -start-filter grep:::!<CR>

" ================
" wiki.vim options
" ================

let g:wiki_filetypes = ['md']
