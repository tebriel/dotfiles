" ~/.vimrc Thanks to pthrash

" Get rid of old vi nastiness
set nocompatible

" VUNDLE
" -----------------------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

"Bundle 'username/reponame'
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-markdown'
Bundle 'mattn/zencoding-vim'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neosnippet'
Bundle 'Valloric/YouCompleteMe'
Bundle 'dhazel/conque-term'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'wavded/vim-stylus'

"Fix bundle stuff
filetype plugin indent on
syntax on
" -----------------------------------------------------------------------------

" HTML and HTMLDjango {{{

augroup ft_html
    au!

    " au FileType html,jinja,htmldjango set softtabstop=2 tabstop=2 shiftwidth=2 textwidth=79
    au BufNewFile,BufRead *.html setlocal filetype=htmldjango

    " Use <localleader>f to fold the current tag.
    au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>f Vatzf

    " Use <localleader>t to fold the current templatetag.
    au FileType html,jinja,htmldjango nmap <buffer> <localleader>t viikojozf

    " Use Shift-Return to turn this:
    "     <tag>|</tag>
    "
    " into this:
    "     <tag>
    "         |
    "     </tag>
    au FileType html,jinja,htmldjango nnoremap <buffer> <s-cr> vit<esc>a<cr><esc>vito<esc>i<cr><esc>

    " Django tags
    au FileType jinja,htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>

    " Django variables
    au FileType jinja,htmldjango inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>
augroup END

" }}}

" Set statements
" -----------------------------------------------------------------------------
set backspace=indent,eol,start "Backspace goes back over indents, \n, and start?
set expandtab "Tab button becomes spaces
set shiftwidth=4 "Tabs are always 4 spaces
set softtabstop=4
set tw=79 "Line width is now 79 chars
set relativenumber "Relative Line Numbers
set autoindent "Pseudo-smart, uses parent indent level
set smartindent "Loads language indent files?
set laststatus=2 "Give us a persistent status line
set shiftround " fancy tabbing so that we don't have irregular tabs
set encoding=utf-8 " For unicode glyphs
set pastetoggle=<F2> "Press to go into paste mode to avoid crazy tabbing
set clipboard=unnamed "Lets us use the macos clipboard from within vim
" Whitespace alerts
match ErrorMsg '\s\+$'
nnoremap <Leader>rtw :%s/\s\+$//e<CR>
" -----------------------------------------------------------------------------

" Give me fancy status line!
" -----------------------------------------------------------------------------
" set statusline=set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P%{fugitive#statusline()}
" -----------------------------------------------------------------------------

" AutoCommands for Events (event bindings)
" -----------------------------------------------------------------------------
au VimResized * :wincmd =
" au FocusLost * :silent! wa
" -----------------------------------------------------------------------------

" Map keybindings for betterer awesomeness
" -----------------------------------------------------------------------------
" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Clear match highlighting
nnoremap <leader><space> :noh<cr>:call clearmatches()<cr>
" Quick buffer switching - like cmd-tab'ing
nnoremap <leader><leader> <c-^>
nnoremap <leader>! :source ~/.vimrc<cr>
nnoremap <leader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
"semi-colon is now colon
nnoremap ; : 
" Changes leader to , instead of default: \
let mapleader = ","
" -----------------------------------------------------------------------------

" vim-powerline settings
" -----------------------------------------------------------------------------
let g:Powerline_symbols = 'fancy'
" -----------------------------------------------------------------------------

" ZenCoding Settings
" -----------------------------------------------------------------------------
let g:user_zen_leader_key = '<c-e>'
let g:user_zen_settings = {'indentation' : '    '} " Set to 4 spaces for tabs
let g:use_zen_complete_tag=1
let g:user_zen_leader_key = '<c-e>'
" -----------------------------------------------------------------------------

" vim-commentary settings
" -----------------------------------------------------------------------------
nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary
" -----------------------------------------------------------------------------

" ctrlp.vim
" -----------------------------------------------------------------------------
let g:ctrlp_map = '<c-t>'
let g:ctrlp_max_height = 30
let g:ctrlp_custom_ignore = { 'dir': 'assets/*' } " |static/js$\|static/img$\|static/css$' }
" -----------------------------------------------------------------------------

set noswf

set undodir=$TMPDIR/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Wildmenu Settings
set wildmenu " cmd line completion a-la zsh
set wildmode=list:longest " matches mimic that of bash or zsh
set wildignore+=node_modules                     " node_modules dir
set wildignore+=.ropeproject                     " py rope cache dir
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=compiled                         " compiled folder
set wildignore+=licenses                         " licenses text folder
set wildignore+=__init__.py                      " __init folder never has useful anything in it
" set wildignore+="main_ui/static/partials"     " stop showing me partials that aren't the ones I want
"colorscheme zenburn
