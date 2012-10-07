"Allow syntax highlighting
syntax on
"Prevents issues with rxvt, vim, and syntax highlighting
"let g:solarized_termcolors=16
"Transparent background i think
"let g:solarized_termtrans=1
"Puts the line numbers to dark
"set background=dark
"Set the colorscheme
"colorscheme solarizEd
"Backspace goes back over indents, \n, and start?
set backspace=indent,eol,start
"Tab button becomes spaces
set expandtab
"Tabs are always 4 spaces
set shiftwidth=4
set softtabstop=4
"Show line numbers
set number
"Get rid of old vi funkiness
set nocompatible
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
endif
