syntax on
colorscheme xoria256
filetype plugin indent on

set number
set relativenumber

set noexpandtab
set softtabstop=0
set tabstop=4
set shiftwidth=4

set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:.

set modeline
set laststatus=2
set ruler
set wildignore+=.git
set wildignore+=*.o,*.pyc
set wildmenu

set hlsearch
set incsearch

set autoread
set encoding=utf-8
set foldmethod=marker
set formatoptions+=j " Delete comment character when joining commented lines
set mouse=

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_bufsettings = 'number relativenumber'

set pastetoggle=<F3>

" F12 toggles display of non-printing characters
nnoremap <F12> :set invlist<CR>

" Double-<Esc> clears search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><Esc>

"if v:version >= 700
"	try
"		runtime autoload/pathogen.vim
"		call pathogen#infect()
"	catch
"	endtry
"endif
