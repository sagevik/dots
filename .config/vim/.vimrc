set nocompatible						"Be iMproved, required for Vundle
set runtimepath^=~/.config/vim
filetype off							"Required

"******************************************************
"    Plugin manager Vundle
"******************************************************
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"
"Plugin 'VundleVim/Vundle.vim'               "Let Vundle manage Vundle, required

"Plugin 'rafi/awesome-vim-colorschemes'      " Colorschemes
"Plugin 'frazrepo/vim-rainbow'               " Rainbow brackets
"Plugin 'itchyny/lightline.vim'
"Plugin 'scrooloose/nerdtree'                " File
"Plugin 'majutsushi/tagbar'                  " Class
"Plugin 'kien/ctrlp.vim'                     " Fuzzy filefinder
"Plugin 'scrooloose/syntastic'               " Syntax/linting
"Plugin 'dense-analysis/ale'                 " Syntax/linting
"Plugin 'Valloric/YouCompleteMe'             " Autocomplete
"Plugin 'ap/vim-buftabline'                  " Display buffers on top
"Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-fugitive'                 " Git
"Plugin 'Yggdroot/indentLine'                " Visual indentation
"Plugin 'python-mode/python-mode'           " Python stuff (code checking, linting etc)
"Plugin 'davidhalter/jedi-vim'               " Python autocomplete
"Plugin 'octol/vim-cpp-enhanced-highlight'   " C++ highlighting
"Plugin 'fatih/vim-go'                       " Vim-go

"call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on

"******************************************************
"    VIM Settings
"******************************************************
syntax on                                  "Enable syntax
let mapleader = " "                        "Set leader key to space

"Good .vimrc info: http://mixandgo.com/blog/vim-config-for-rails-ninjas
set encoding=utf-8
set background=dark                        "Set dark terminal background
set t_Co=256                               "Set 256 colors in terminal
set conceallevel=1
set viminfo+=n~/.config/vim/.viminfo
set path+=**                               "File search from project root folder using :find
set hidden                                 "Switch to an other buffer/window without saving file
set confirm                                "Ask for confirmation when abandoning a buffer
set autowrite                             "Automatically write/save buffer before it is hidden
set autowriteall                          "Automatically write/save buffer before it is hidden
set ttyfast                                "Improve vim's scrolling speed
set ttyscroll=3                            "Improve vim's scrolling speed
set lazyredraw                             "Improve vim's scrolling speed
set wildmenu                               "Show completion on the mode-line
set linespace=1                            "Number of pixels between the lines
set splitbelow                             "Open new split below current
set splitright                             "Open new split to the right of current
"set noshowmode                             "Hide display of mode
"set wrap                                  "Wrap long lines
set nowrap                                 "Disable wrapping of long lines
set linebreak                              "Break lines at word end
set autoread                               "Reload file when it changes on disk
set undofile                               "Enable undo
set undodir=~/.config/vim/undo_files//     "Set undo directory
set backupdir=~/.config/vim/backup_files// "Set backup directory
set directory=~/.config/vim/swap_files//   "Set swap directory
set clipboard=unnamed                      "Enable copy/paste to/from system
set backspace=2                            "Enable backspace
set laststatus=2                           "Always show statusline
set number                                 "Enable linenumbers
set relativenumber                         "Enable relative linenumbers
"set ruler                                  "Enable ruler
set cursorline                             "Highlight current line
set showmatch                              "Show matching brackets
set foldmethod=manual                      "Enable code folding
set foldnestmax=1                          "Nr of folds
set nofoldenable                           "Start with no folds
set hlsearch                               "Highlight search
set incsearch                              "Incremental search
set ignorecase                             "Case insensitive search
set smartcase                              "Case sensitive when one capital letter
set winheight=5                           "Set height of current window
set winminheight=2                         "Set minimum height of new split
set expandtab                              "Expand tabs to spaces
set tabstop=4                              "Tabs and spaces
set softtabstop=4                          "Tabs and spaces
set shiftwidth=4                           "Tabs and spaces

" Use a line cursor within insert mode and a block cursor everywhere else.

" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

if has("autocmd")
    autocmd FileType make set noexpandtab
    "If file is Makefile, use tabs instead of spaces
endif

"Test of c++ compile by F9 and run by F5
"set makeprg=g++\ -o\ \"%:p:r\"\ \"%:p\"
map <F9> :!make<CR>
map <F5> :!clear<CR>:!%:p:r<CR>

"autocmd BufWinLeave *.* mkview
"autocmd BufWinLeave *.* loadview

"Colorschemes and colors
colorscheme angr

highlight Cursorline ctermbg=235
highlight ColorColumn ctermbg=233
:au BufEnter *.* : set colorcolumn=

"Colours for mathing brackets
hi MatchParen cterm=bold ctermbg=208 ctermfg=232

" Keymapping
" move lines
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Auto bracket
" inoremap { {}<ESC>ha
" inoremap ( ()<ESC>ha
" inoremap [ []<ESC>ha
" inoremap " ""<ESC>ha
" inoremap ' ''<ESC>ha
" inoremap ` ``<ESC>ha

"nnoremap <C-w><C-]> :vert winc ]<CR>
"Remove search highlighting
nnoremap <leader>s :noh<cr>
nnoremap <leader><ESC> :noh<cr>

" Show invisible characters (end of line, tabs, spaces etc)
"set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
"set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
"set listchars=tab:>·,extends:>,precedes:<
"set list								"Set whitespace characters visible

" Automatic ctags
"au BufWritePost *.c,*.cpp,*.h,*.py silent! !ctags -R &

"autocmd BufNewFile,BufRead *.json set filetype=javascript

" File templates
"autocmd BufNewFile *.cpp r ~/.vim/templates/template.cpp
"autocmd BufNewFile *.py r ~/.vim/templates/template.py

" Highlight trailing whitespace
highlight link sensibleWhitespaceError Error
autocmd Syntax * syntax match sensibleWhitespaceError excludenl /\s\+\%#\@<!$\| \+\ze\t/ display containedin=ALL

"******************************************************
"    Plugin settings and configuration
"******************************************************

" Tagbar
" map <F4> :TagbarToggle<CR>
" let g:tagbar_left = 0
" let g:tagbar_width = 30
" let g:tagbar_autofocus = 1

" NERDTree
" map <F3> :NERDTreeToggle<CR>
" let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" CtrlP
" ignore these files and folders on file finder
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
"   \ 'file': '\.pyc$\|\.pyo$',
"   \ }
"
" BufTabline
" https://github.com/ap/vim-buftabline/blob/master/doc/buftabline.txt
" let g:buftabline_show=2
" let g:buftabline_numbers=1
" let g:buftabline_indicators=1
" let g:buftabline_separators=1

" Lightline statusbar
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" UltiSnip
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<c-tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:UltiSnipsEditSplit="vertical"

"IndentLine
"https://github.com/Yggdroot/indentLine
"let g:indentLine_setColors = 0
"let g:indentLine_char='┆'
" let g:indentLine_enabled=1
" let g:indentLine_conceallevel=1

"Python syntax
" let python_highlight_all = 1

"YouCompleteMe
"let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py"
"let g:ycm_add_preview_to_completeopt=1
"let g:ycm_autoclose_preview_window_after_completion=1
"let g:ycm_autoclose_preview_window_after_insertion=1
"map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

"Resize vim windows when terminal is resized
" autocmd VimResized * :wincmd =

" autocmd BufLeave,FocusLost * silent! update

" Copy from one vim to another
vmap <leader>y :w! /tmp/vitmp<CR>
nmap <leader>p :r! cat /tmp/vitmp<CR>

" Syntastic checkers
" let g:syntastic_python_checkers = ['pylint']

" Rainbow brackets
" let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

