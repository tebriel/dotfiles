" ~/.vimrc Thanks to pthrash

" Get rid of old vi nastiness
set nocompatible
"set shell=/bin/bash

" VUNDLE
" -----------------------------------------------------------------------------
filetype off
set rtp+=/usr/local/opt/fzf

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Bundle 'username/reponame'
Plugin 'VundleVim/Vundle.vim'

" General Utility
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'direnv/direnv.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'ciaranm/securemodelines'
Plugin 'rking/ag.vim'
Plugin 'junegunn/fzf'
" Figure out tabs
Plugin 'tpope/vim-sleuth'

" Visual Stuff
Plugin 'bling/vim-airline'
Plugin 'dracula/vim'
" Plugin 'NLKNguyen/papercolor-theme'

" Language Tools
" Plugin 'klen/python-mode'
Plugin 'fatih/vim-go'
Plugin 'dense-analysis/ale'
" Plugin 'scrooloose/syntastic'
" Plugin 'mtscout6/syntastic-local-eslint.vim'
Plugin 'valloric/YouCompleteMe'
Plugin 'psf/black'

" Ruby Stuff
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-dispatch'

" Language Syntax
Plugin 'dag/vim-fish'
Plugin 'robbles/logstash.vim'
Plugin 'ingydotnet/yaml-vim'
Plugin 'vim-scripts/groovy.vim'
Plugin 'chikamichi/mediawiki.vim'
Plugin 'tpope/vim-markdown'
Plugin 'groenewege/vim-less'
Plugin 'Konfekt/FastFold'
Plugin 'lepture/vim-jinja'
Plugin 'leafgarland/typescript-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-test/vim-test'
Plugin 'LnL7/vim-nix'

call vundle#end() " required

"Fix bundle stuff
filetype plugin indent on
syntax on
" -----------------------------------------------------------------------------

" Set statements
" -----------------------------------------------------------------------------
set backspace=indent,eol,start "Backspace goes back over indents, \n, and start?
set expandtab "Tab button becomes spaces
set shiftwidth=4 "Tabs are always 4 spaces
set ts=4
set softtabstop=4
set tabstop=4
set et "Expand tabs
set tw=110 "Line width is now 99 chars
" autocmd FileType python set colorcolumn=110
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
nnoremap <leader>ftnl :%s/#012/\r/ge<CR>
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

" -----------------------------------------------------------------------------
" vim-commentary settings
" -----------------------------------------------------------------------------
nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary
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
" colorscheme solarized

" papercolor-theme
" set t_Co=256 " Required, possibly
" set background=light
" colorscheme PaperColor

" -----------------------------------------------------------------------------
" pymode settings    (python)
" -----------------------------------------------------------------------------
let g:pymode_rope = 0 " just disable rope, it's not worth the pain
let g:pymode_rope_completion = 0 " Code Completion
let g:pymode_rope_complete_on_dot = 0 " Do code completion on '.'
let g:pymode_lint_config = '$HOME/pylint.rc'
let g:pymode_options_max_line_length = 110
let g:pymode_trim_whitespaces = 1 " Auto-trim whitespace on save
let g:pymode_options_colorcolumn = 1 " Show a colorcolumn at max line length
" let g:pymode_lint = 0 " Let's use syntastic for python checking
" let g:pymode_python = 'python3' " Always use python2
" au FileType python nmap <leader>2 let g:pymode_python=python <CR>
" au FileType python nmap <leader>3 let g:pymode_python=python3 <CR>
" -----------------------------------------------------------------------------

augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end

" The following should be unnecessary because of vim-sleuth
" -----------------------------------------------------------------------------
" filetype settings
" -----------------------------------------------------------------------------
" ruby 2 space config
" autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
" yaml 2 space config
" autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
" yaml 2 space config
" autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
" autocmd Filetype typescript setlocal ts=2 sts=2 sw=2
" autocmd Filetype html setlocal ts=2 sts=2 sw=2
" autocmd Filetype groovy setlocal ts=2 sts=2 sw=2
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" syntastic settings
" -----------------------------------------------------------------------------
" golang syntastic checking
" let g:syntastic_go_checkers = ['go', 'govet', 'golint', 'errcheck']
" let g:syntastic_go_govet_args = "-shadow=true" Syntastic doesn't allow govet args, see the help
" let g:syntastic_sh_checkers = ['shellcheck']
" let g:syntastic_sh_shellcheck_args = "-x"
" let g:syntastic_python_checkers = ['python', 'flake8']
" let g:syntastic_python_flake8_args = "--config $HOME/.flake8"
" let g:syntastic_rust_checkers = ['cargo']
" let g:syntastic_sql_checkers = ['sqlint']
" let g:syntastic_typescript_checkers = ['tslint --type-check']
" " let g:syntastic_loc_list_height = 5 " Shorten the quickfix height to 5
" " let g:syntastic_ruby_checkers = ['rubocop']
" " let g:syntastic_javascript_checkers = ['eslint']
" " let g:syntastic_javascript_eslint_exec ='npm run lint --'
" " Helps fix the speed issues in vim
" " let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" " Sometimes go stuff doesn't appear in the small buffer
" let g:go_list_type = "quickfix"
" " Yaml checker for vim/syntastic
" let g:syntastic_yaml_checkers = ['yamllint']
" " Syntastic settings
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" ale settings
" -----------------------------------------------------------------------------
let g:ale_linters = {
\   'ruby': ['rubocop'],
\}
let g:airline#extensions#ale#enabled = 1
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" neocomplete settings
" -----------------------------------------------------------------------------
" let g:neocomplete#enable_at_startup = 1 " startup
" let g:neocomplete#enable_smart_case = 1 " smart case which i assume is case-insensitive, mostly
" " Recommended key-mappings.
" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
"   " For no inserting <CR> key.
"   "return pumvisible() ? "\<C-y>" : "\<CR>"
" endfunction
" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" " <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" -----------------------------------------------------------------------------

" Tab Completion

" -----------------------------------------------------------------------------
" vim-go
" -----------------------------------------------------------------------------
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" -----------------------------------------------------------------------------
" ctrlp.vim
" -----------------------------------------------------------------------------
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_max_height = 30
" let g:ctrlp_custom_ignore = { 'dir': 'vendor$\|tmp' }
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" fzf.vim
" -----------------------------------------------------------------------------
nmap <C-P> :FZF<CR>
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" vim-test.vim
" -----------------------------------------------------------------------------
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#strategy = "dispatch"
" -----------------------------------------------------------------------------
