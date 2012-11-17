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
Bundle 'Shougo/neocomplcache'
Bundle 'dhazel/conque-term'

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
" -----------------------------------------------------------------------------

" Give me fancy status line!
" -----------------------------------------------------------------------------
" set statusline=set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P%{fugitive#statusline()}
" -----------------------------------------------------------------------------

" AutoCommands for Events (event bindings)
" -----------------------------------------------------------------------------
au VimResized * :wincmd =
au FocusLost * :silent! wa
" -----------------------------------------------------------------------------

" Map keybindings for betterer awesomeness
" -----------------------------------------------------------------------------
" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Clear match highlighting
noremap <leader><space> :noh<cr>:call clearmatches()<cr>
" Quick buffer switching - like cmd-tab'ing
nnoremap <leader><leader> <c-^>
nnoremap <Leader>! :source ~/.vimrc<cr>
"semi-colon is now colon
nnoremap ; : 
let mapleader = "," " Changes leader to , instead of default: \
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
" -----------------------------------------------------------------------------

" neocomplcache
" -----------------------------------------------------------------------------
" NOTE: There are a lot of settings for this plugin. This config is
" very fragile. I don't exactly understand what everything in here
" does, but if you fuck with it, neocomplcache doesn't do what you
" want, so here it is. After much work / effort / trial and error, the
" below config works as closely to intellisense I could get it.

" Only show if I've stopped typing for a tenth second.
let g:neocomplcache_enable_cursor_hold_i = 1
let g:neocomplcache_cursor_hold_i_time = 100

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_auto_delimiter = 1

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 0

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" <CR>: close popup 
" <s-CR>: close popup and save indent.
" inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
" inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<CR>" : "\<CR>" 
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" User defined snippets
let g:neocomplcache_snippets_dir = '~/.vim/mysnippets/'

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" }}}
" -----------------------------------------------------------------------------
set noswf

set undodir=$TMPDIR/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

"colorscheme zenburn
