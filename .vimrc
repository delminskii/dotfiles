"
" A (not so) minimal vimrc.
"

" You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
" We set it explicitely to make our position clear!
set nocompatible

set autoread

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.
set scrolloff   =4
set scrolljump  =4

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

"map <silent> <Space> <Leader>
"let mapleader   ="\<Space>"

" omnicompletion settings
set completeopt+=longest,menuone
set completeopt-=preview


" Toggling for paste mode
set pastetoggle =<F2>

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set number                 " show numbers

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.
set ignorecase
set smartcase
set showmatch

" Change directory to the current buffer when opening files.
set autochdir

" Encodings
set ffs         =unix,dos,mac
set fencs       =utf-8,cp1251,koi8-r,ucs-2,cp866

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set wrap
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set matchpairs+=<:>                         " additional matchpairs:
set tw          =80

set termguicolors


function! LangRunner()
    if(&ft=="python")
        nnoremap <Leader>r :w<cr>:!python %<cr>
    elseif(&ft=="sh")
        nnoremap <Leader>r :w<cr>:!bash %<cr>
    elseif(&ft=="perl")
        nnoremap <Leader>r :w<cr>:!perl %<cr>
    endif
endfunction

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
"if &shell =~# 'fish$'
  "set shell=/bin/bash
"endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'                    " emmet for HTML\CSS
Plugin 'easymotion/vim-easymotion'          " easymotion for vim
Plugin 'jiangmiao/auto-pairs'               " auto [({, quotes and so on
Plugin 'tpope/vim-surround'                 " auto-pairs alternative
"Plugin 'majutsushi/tagbar'                  " class\module browser
Plugin 'Vimjas/vim-python-pep8-indent'      " PEP8 indent
"Plugin 'tpope/vim-fugitive'                 " Vim plugin for git functionals
Plugin 'vim-airline/vim-airline'            " Lean & mean status/tabline for vi
Plugin 'vim-airline/vim-airline-themes'     " airline themes
Plugin 'ctrlpvim/ctrlp.vim'                 " fuzzy search (files)
Plugin 'morhetz/gruvbox'                    " colorscheme
"Plugin 'tacahiroy/ctrlp-funky'              " fuzzy function search (code)
Plugin 'w0rp/ale'                           " linting ANY (!!!) code
Plugin 'heavenshell/vim-pydocstring'        " python docstring
Plugin 'scrooloose/nerdcommenter'           " commenting
Plugin 'scrooloose/nerdtree'                " file browser
Plugin 'gregsexton/MatchTag'                " highlight pairs tags
"Plugin 'flazz/vim-colorschemes'
"Plugin 'godlygeek/tabular'                  " smart tabbing
Plugin 'terryma/vim-multiple-cursors'       " sublime-like multiple cursors
Plugin 'triglav/vim-visual-increment'       " inc/dec by C-A/C-X
Plugin 'mhinz/vim-startify'                 " startup
Plugin 'Glench/Vim-Jinja2-Syntax'           " Jinja2 syntax
Plugin 'kassio/neoterm'                     " :terminal features
Plugin 'dhruvasagar/vim-table-mode'         " table editiion <leader>tm

"Good colorschemes for me
"Plugin 'w0ng/vim-hybrid'
"Plugin 'morhetz/gruvbox'
"Plugin 'chriskempson/base16-vim'
"Plugin 'sjl/badwolf'
"Plugin 'rakr/vim-one'
"Plugin 'dikiaap/minimalist'
"Plugin 'tomasr/molokai'

" Snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

call vundle#end()

" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap//
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/

"comment line below if nvim is ised
"set viminfo     ='100,n$HOME/.vim/files/info/viminfo

" Disable Arrow keys in Normal mode
map <silent><up> <nop>
map <silent><down> <nop>
map <silent><left> <nop>
map <silent><right> <nop>

" Disable Arrow keys in Insert mode
imap <silent> <up> <nop>
imap <silent> <down> <nop>
imap <silent> <left> <nop>
imap <silent> <right> <nop>

" clear search-highlight
nmap <silent> <Leader>/ :nohlsearch<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Open new blank file
nnoremap n<C-h> :lefta vsp new<cr>
nnoremap n<C-j> :bel sp new<cr>
nnoremap n<C-k> :abo sp new<cr>
nnoremap n<C-l> :rightb vsp new<cr>

" Move window
nnoremap <Leader><C-h> <C-W>H
nnoremap <Leader><C-j> <C-W>J
nnoremap <Leader><C-k> <C-W>K
nnoremap <Leader><C-l> <C-W>L

" Maximise horizontally
map <Leader>= <C-w><Bar>

" Maximise vertically
map <Leader>- <C-w>_

" Make all windows equally sized
map <Leader><Leader> <C-w>=

" Change windowsizes in visual mode
" horizontally - always three chars else it takes ages
vnoremap - 3<C-w><
vnoremap = 3<C-w>>

" Vertically - always three chars else it takes ages
vnoremap _ 3<C-w>-
vnoremap + 3<C-w>+

" Mappings for tabs
noremap <Leader>1 1gt
noremap <Leader>2 2gt
noremap <Leader>3 3gt
noremap <Leader>4 4gt
noremap <Leader>5 5gt
noremap <Leader>6 6gt
noremap <Leader>7 7gt
noremap <Leader>8 8gt
noremap <Leader>9 9gt
noremap <Leader>0 :tablast<CR>
map <silent> <Leader>t :tabnew<CR>
map <silent> <Leader>w :tabclose<CR>

" Prettify JSON
nnoremap =j :%!python -m json.tool<CR>
vnoremap =j :%!python -m json.tool<CR>



" =============================================================================
" TagBar settings
" =============================================================================
"map <silent> <F4> :TagbarToggle<CR>
"let g:tagbar_autofocus = 1
"let g:tagbar_width = 30
"let g:tagbar_autoclose = 1
"let g:tagbar_compact = 1


" =============================================================================
" Nerdtree settings
" =============================================================================
map <Leader>n :NERDTreeToggle<CR>


" =============================================================================
" Ale settings
" =============================================================================
let g:ale_linters = {
\   'python': ['flake8'],
\}
let g:ale_sign_warning = '→'
"let g:ale_sign_warning = ''
let g:ale_sign_error = '×'


" =============================================================================
" Emmet-settings 
" =============================================================================
let g:user_emmet_leader_key='<TAB>'
let g:user_emmet_install_global = 0             " take a look at vimrc_autocmd


" =============================================================================
" Colorscheme colors
" =============================================================================
set background=dark
colorscheme gruvbox


" =============================================================================
" Vim-airline options
" =============================================================================
set laststatus=2
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" good themes for me also: hybridline, badwolf, gruvbox, term, base16_chalk,
" simple
let g:airline_theme='gruvbox'


" =============================================================================
" CtrlP options
" =============================================================================
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_working_path_mode = 'ra'


" =============================================================================
" CtrlPFunky settings
" =============================================================================
nnoremap <Leader>f :CtrlPFunky<CR>
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1


" =============================================================================
" Pydocstring options
" =============================================================================
nmap <silent> <Leader>d <Plug>(pydocstring)


" =============================================================================
" Auto-pairs options
" =============================================================================
let g:AutoPairsShortcutFastWrap = '<Leader>e'


" =============================================================================
" Neoterm options
" =============================================================================
" Useful maps
" hide/close terminal
nnoremap <silent> <Leader>th :call neoterm#close()<CR>
" clear terminal
nnoremap <silent> <Leader>tl :call neoterm#clear()<CR>
" kills the current job (send a <c-c>)
nnoremap <silent> <Leader>tc :call neoterm#kill()<CR>
" open terminal
nnoremap <silent> <Leader>to :call neoterm#open()<CR>

" =============================================================================
" Easy-motion options
" =============================================================================
" Disable default mappings"
let g:EasyMotion_do_mapping = 0

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <silent> s <Plug>(easymotion-overwin-f)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


" =============================================================================
" My custom autocmds
" =============================================================================
augroup vimrc_autocmd
  autocmd!
  autocmd FileType html,xml,svg,css,htmldjango,scss,smarty EmmetInstall
  "autocmd BufNewFile,BufRead *.tpl set ft=jinja

  au BufEnter * call LangRunner()
augroup END
