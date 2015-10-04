" ~/.vimrc Thanks to pthrash
execute pathogen#infect()

" Get rid of old vi nastiness
set nocompatible
set shell=/bin/bash

" VUNDLE
" -----------------------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Bundle 'username/reponame'
Plugin 'gmarik/Vundle.vim'

Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-markdown'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neosnippet'
Bundle 'Valloric/YouCompleteMe'
Bundle 'dhazel/conque-term'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'wavded/vim-stylus'
Bundle 'ciaranm/securemodelines'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'dag/vim-fish'
Bundle 'godlygeek/tabular'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'dart-lang/dart-vim-plugin'
Bundle 'kchmck/vim-coffee-script'
Bundle 'rking/ag.vim'
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'
Bundle 'bling/vim-airline'
Bundle 'tebriel/logstash.vim'
Bundle 'tpope/vim-rails'
Bundle 'KurtPreston/vim-autoformat-rails'
Bundle 'derekwyatt/vim-scala'

call vundle#end() " required

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
set et "Expand tabs
set tw=79 "Line width is now 79 chars
set relativenumber "Relative Line Numbers
set autoindent "Pseudo-smart, uses parent indent level
set laststatus=2 "Give us a persistent status line
set shiftround " fancy tabbing so that we don't have irregular tabs
set encoding=utf-8 " For unicode glyphs
set pastetoggle=<F2> "Press to go into paste mode to avoid crazy tabbing
set clipboard=unnamed "Lets us use the macos clipboard from within vim
set autoread "Pull in new buffers when files changed behind the scenes (use :checktime after pulling)
set completeopt-=preview " Don't show the preview window when doing completions and shit.
" Whitespace alerts
au BufNewFile,BufRead * match ErrorMsg '\s\+$'
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
" Changes leader to , instead of default: \
let mapleader = ","
" Never have I wanted that stupid window
map q: :q
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Clear match highlighting
nnoremap <leader><space> :noh<cr>:call clearmatches()<cr>
" Quick buffer switching - like cmd-tab'ing
nnoremap <leader><leader> <c-^>
nnoremap <leader>! :source ~/.vimrc<cr>
nnoremap <leader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
"semi-colon is now colon
nnoremap ; :
nnoremap <leader>rtw :%s/\s\+$//e<CR>
nnoremap <leader>w :wall<CR>
nnoremap K <nop>
vnoremap K <nop>
cnoremap sudow w !sudo tee % >/dev/null
" vim-powerline settings
" -----------------------------------------------------------------------------
" let g:Powerline_symbols = 'fancy'
" python from powerline.vim import setup as powerline_setup
" python powerline_setup()
" python del powerline_setup
" -----------------------------------------------------------------------------

" vim-airline settings
" -----------------------------------------------------------------------------
let g:airline_powerline_fonts=1
let g:airline_section_c='%t'
" -----------------------------------------------------------------------------

" ZenCoding Settings
" -----------------------------------------------------------------------------
let g:user_zen_leader_key = '<c-e>'
let g:user_zen_settings = {'indentation' : '    '} " Set to 4 spaces for tabs
let g:use_zen_complete_tag=1
let g:user_zen_leader_key = '<c-e>'
" -----------------------------------------------------------------------------

" Dash Settings
let g:dash_map = {
  \ 'coffee':       'js',
  \ 'less':         'css',
  \ 'python':       'py'
  \}
nmap <silent> <leader>d <Plug>DashSearch
vmap <silent> <leader>d <Plug>DashSearch
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
let g:ctrlp_custom_ignore = { 'dir': 'vendor$\|tmp' }
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
set wildignore+=coverage                         " coverage folder
set wildignore+=licenses                         " licenses text folder
set wildignore+=npm_cache                        " npm_cache folder
set wildignore+=pyes
set wildignore+=docs
set wildignore+=django-piston
" set wildignore+="main_ui/static/partials"     " stop showing me partials that aren't the ones I want
"colorscheme zenburn

" nathanaelkane/vim-indent-guides Settings
" -----------------------------------------------------------------------------
let g:indent_guides_guide_size = 1


" jedi-python
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 0

" pymode
let g:pymode_rope_complete_on_dot = 0

" ruby 2 space config
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
