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

"set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set wrap
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set matchpairs+=<:>                         " additional matchpairs:
set tw          =80

set termguicolors


function! LangRunner()
    if(&ft=="python")
        nnoremap <Leader>r :w<CR>:!python %<CR>
    elseif(&ft=="sh")
        nnoremap <Leader>r :w<CR>:!bash %<CR>
    elseif(&ft=="perl")
        nnoremap <Leader>r :w<CR>:!perl %<CR>
    endif
endfunction


function! StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
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


" =============================================================================
" plug-vim settings
" =============================================================================
let g:plug_threads = 2

call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim', { 'for': ['html', 'xml'] }
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'andrewradev/splitjoin.vim'
Plug 'junegunn/fzf.vim'
Plug 'joshdick/onedark.vim'
Plug 'w0rp/ale'
Plug 'cohama/agit.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'gregsexton/MatchTag'
Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-startify'
Plug 'sheerun/vim-polyglot'
Plug 'kassio/neoterm', { 'on': 'Ttoggle' }
Plug 'dhruvasagar/vim-table-mode'

" Good colorschemes for me:
" - afterglow from Plugin 'rafi/awesome-vim-colorschemes'
" - Plug 'icymind/NeoSolarized'
" - Plug 'joshdick/onedark.vim'
" - Plug 'w0ng/vim-hybrid'
" - Plug 'morhetz/gruvbox'
" - Plug 'chriskempson/base16-vim'
" - Plug 'sjl/badwolf'
" - Plug 'rakr/vim-one'
" - Plug 'dikiaap/minimalist'
" - Plug 'tomasr/molokai'

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

call plug#end()

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
nnoremap n<C-h> :lefta vsp new<CR>
nnoremap n<C-j> :bel sp new<CR>
nnoremap n<C-k> :abo sp new<CR>
nnoremap n<C-l> :rightb vsp new<CR>

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

" Apply vimrc's changes
nmap <silent> <Leader>sv :source $HOME/.vimrc<CR>

" Strip lines
nnoremap <silent> <Leader>sl :call StripTrailingWhitespaces()<CR>


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
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 0
let g:ale_echo_delay = 1000
"let g:ale_sign_warning = ''
"let g:ale_sign_error = '×'
let g:ale_sign_warning = '→'
let g:ale_sign_error = '✗'


" =============================================================================
" Emmet-settings
" =============================================================================
let g:user_emmet_leader_key='<TAB>'
let g:user_emmet_install_global = 0             " take a look at vimrc_autocmd


" =============================================================================
" Colorscheme colors
" =============================================================================
set background=dark
colorscheme onedark


" =============================================================================
" Vim-airline settings
" =============================================================================
set laststatus=2
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

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

" good themes for me also:
" - hybridline
" - badwolf
" - gruvbox
" - term
" - base16_chalk
" - simple
let g:airline_theme='onedark'


" =============================================================================
" FZF settings
" =============================================================================
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

command! -bang FLines call fzf#vim#grep(
    \ 'grep -vnITr --color=always
    \ --exclude-dir=".svn"
    \ --exclude-dir=".git"
    \ --exclude-dir="htmls"
    \ --exclude=tags
    \ --exclude=*\.pyc
    \ --exclude=*\.exe
    \ --exclude=*\.dll
    \ --exclude=*\.zip
    \ --exclude=*\.gz "^$"',
    \ 0,
    \ {'options': '--reverse --prompt "FLines> "'})

nmap <silent> <Leader>fl :FLines<CR>
nmap <silent> <Leader>l :Lines<CR>
nmap <silent> <Leader>f :Files<CR>
nmap <silent> <Leader>uf :Files ..<CR>


" =============================================================================
" Pydocstring options
" =============================================================================
nmap <silent> <Leader>d <Plug>(pydocstring)


" =============================================================================
" Neoterm settings
" =============================================================================
nnoremap <silent> <Leader>to :Ttoggle<CR>
nnoremap <silent> <Leader>tl :Tclear<CR>
let g:neoterm_autoscroll = 1
let g:neoterm_autoinsert = 1


" =============================================================================
" Startify options
" =============================================================================
let g:startify_bookmarks = [
    \ {'v': '~/.vimrc'},
    \ {'b': '~/.bashrc'},
    \ {'x': '~/.Xresources'},
    \ {'w': '~/.wgetrc'}
    \ ]
let g:startify_list_order = [
    \ ['    MRU files:'],
    \ 'files',
    \ ['    Bookmarks'],
    \ 'bookmarks',
    \ ]
nnoremap <silent> <Leader>sr :Startify<CR>


" =============================================================================
" Deoplete settings
" =============================================================================
let g:deoplete#enable_at_startup = 1


" =============================================================================
" Deoplete-jedi settings
" =============================================================================
let g:deoplete#sources#jedi#show_docstring = 1
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'


" =============================================================================
" Splitjoin settings
" =============================================================================
nmap <Leader>S :SplitjoinSplit<CR>
nmap <Leader>J :SplitjoinJoin<CR>


" =============================================================================
" Agit settings
" =============================================================================
nmap <Leader>ag :Agit<CR>


" =============================================================================
" Easy-motion options
" =============================================================================
" Disable default mappings"
let g:EasyMotion_do_mapping = 0

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <silent> s <Plug>(easymotion-overwin-f)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


" =============================================================================
" Augroup, autocmd
" =============================================================================
augroup vimrc_autocmd
  autocmd!
  autocmd FileType html,xml,svg,css,htmldjango,scss,smarty EmmetInstall

  au BufEnter * call LangRunner()
augroup END
