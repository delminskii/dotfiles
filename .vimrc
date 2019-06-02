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
set hidden                         " Switch between buffers without having to save first.
set laststatus  =2                 " Always show statusline.
set display     =lastline          " Show as much as possible of the last line.

" omnicompletion settings
set completeopt+=longest,menuone
set completeopt-=preview

set noshowmode             " Don't show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set number                 " show numbers

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.
set ignorecase
set smartcase
set showmatch

set autochdir              " Change directory to the current buffer when opening files.

" Encodings
set ffs         =unix,dos,mac
set fencs       =utf-8,cp1251,koi8-r,ucs-2,cp866

set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set wrap
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.
set tw          =80

set termguicolors

" disable change of curso shape
set guicursor=

" Run code from current buffer pressing leader+r
function! LangRunner()
    if(&ft=="python")
        nnoremap <Leader>r :w<CR>:!python3.7 %<CR>
    elseif(&ft=="sh")
        nnoremap <Leader>r :w<CR>:!bash %<CR>
    elseif(&ft=="go")
        nnoremap <Leader>r :w<CR>:!go run %<CR>
    endif
endfunction

" Visual mode pressing * or # searches for the current selection;
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call general#VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call general#VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Show non-printable characters.
set list
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif


" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif


" =============================================================================
" plug-vim settings
" =============================================================================
let g:plug_threads = 2

call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim', { 'for': ['html', 'xml'] }
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-surround'
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'andrewradev/splitjoin.vim'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'morhetz/gruvbox'
Plug 'cohama/agit.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'heavenshell/vim-pydocstring', { 'for': 'python' }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-startify'
Plug 'sheerun/vim-polyglot'
Plug 'kassio/neoterm', { 'on': 'Topen' }

" Good colorschemes for me:
" - `afterglow` from Plugin 'rafi/awesome-vim-colorschemes'
" - Plug 'icymind/NeoSolarized'
" - Plug 'joshdick/onedark.vim'
" - Plug 'w0ng/vim-hybrid'
" - Plug 'morhetz/gruvbox'
" - Plug 'chriskempson/base16-vim'
" - Plug 'sjl/badwolf'
" - Plug 'rakr/vim-one'
" - Plug 'rakr/vim-two-firewatch'
" - Plug 'dikiaap/minimalist'
" - Plug 'tomasr/molokai'
" - Plug 'ajh17/Spacegray.vim'
" - Plug 'cocopon/iceberg.vim'

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
set updatecount =200
set undofile
set undodir     =$HOME/.vim/files/undo/

" Increase/decrease windows' size (up/right +, bot/left -)
nnoremap <silent><up> 10<C-w>+
nnoremap <silent><down> 10<C-w>-
nnoremap <silent><left> 10<C-w><
nnoremap <silent><right> 10<C-w>>

" Clear search-highlight
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" Use Ctrl-[hjkl] to select an active split!
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" Open new blank file
nnoremap <silent> n<C-h> :lefta vsp new<CR>
nnoremap <silent> n<C-j> :bel sp new<CR>
nnoremap <silent> n<C-k> :abo sp new<CR>
nnoremap <silent> n<C-l> :rightb vsp new<CR>

" Move window <S-A-hjkl>
nnoremap <silent> <S-M-h> <C-W>H
nnoremap <silent> <S-M-j> <C-W>J
nnoremap <silent> <S-M-k> <C-W>K
nnoremap <silent> <S-M-l> <C-W>L

" <Leader>$n to move to tab$n, $n in [1;9]
let tabnum = 1
while tabnum < 10
    execute 'nnoremap <silent> <Leader>'.tabnum tabnum.'gt'
    let tabnum = tabnum + 1
endwhile
nnoremap <silent> <Leader>0 :tablast<CR>
nnoremap <silent> <Leader>t :tabnew<CR>
nnoremap <silent> <Leader>w :tabclose<CR>

" Prettify valid JSON contents
nnoremap =j :%!python -m json.tool<CR>
vnoremap =j :%!python -m json.tool<CR>

" Move a line of text using Alt+[jk]
nnoremap <silent> <M-j> mz:m+<cr>`z
nnoremap <silent> <M-k> mz:m-2<cr>`z
vnoremap <silent> <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <silent> <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Save current buffer into current opened file
nnoremap <F1> :update<CR>

" Open the selected text in a split (should be a file).
noremap <Leader>o "oyaW:sp <C-R>o<CR>
xnoremap <Leader>o "oy<esc>:sp <C-R>o<CR>
vnoremap <Leader>o "oy<esc>:sp <C-R>o<CR>

" Indent shortcut
nnoremap <silent> > >>
nnoremap <silent> < <<

" Deprecate skip selection after indenting
vnoremap <silent> < <gv
vnoremap <silent> > >gv


" =============================================================================
" Nerdtree settings
" =============================================================================
nnoremap <Leader>n :NERDTreeToggle<CR>


" =============================================================================
" Ale settings
" =============================================================================
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_linters = {
\   'python': ['flake8'],
\}
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 0
let g:ale_echo_delay = 1000
let g:ale_sign_warning = ''
let g:ale_sign_error = '×'
"let g:ale_sign_warning = '→'
"let g:ale_sign_error = '✗'


" =============================================================================
" Emmet-settings
" =============================================================================
let g:user_emmet_leader_key='<TAB>'
let g:user_emmet_install_global = 0


" =============================================================================
" Colorscheme colors
" =============================================================================
"set background=dark
if strftime('%H') >= 7 && strftime('%H') < 19
  let g:gruvbox_contrast_light='medium'
  set background=light
else
  let g:gruvbox_contrast_dark='medium'
  set background=dark
endif
colorscheme gruvbox


" =============================================================================
" Vim-lightline settings
" =============================================================================
let g:lightline = {
\   'colorscheme': 'deus',
\}
" good themes for me:
" - hybridline
" - badwolf
" - gruvbox
" - term
" - base16_chalk
" - simple


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

nnoremap <silent> <Leader>fl :FLines<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>


" =============================================================================
" Pydocstring settings
" =============================================================================
nmap <silent> <Leader>d <Plug>(pydocstring)


" =============================================================================
" Nerdcommenter settings
" =============================================================================
let g:NERDDefaultAlign = 'left'


" =============================================================================
" Neoterm settings
" =============================================================================
nnoremap <silent> <Leader><Enter> :Topen<CR>
tnoremap <silent> <Leader><Enter> <C-\><C-n>:Tclose<CR>
let g:neoterm_default_mod = 'botright'
let g:neoterm_autoscroll = 1
let g:neoterm_autoinsert = 1


" =============================================================================
" Startify settings
" =============================================================================
let g:startify_session_dir = '~/.vim/session'
let g:startify_session_persistence = 1
let g:startify_bookmarks = [
    \ {'v': '~/.vimrc'},
    \ {'b': '~/.bashrc'},
    \ {'x': '~/.Xresources'},
    \ {'w': '~/.wgetrc'},
    \ {'s': '~/.ssh/config'},
    \ {'o': '~/.config/openbox/'},
    \ ]
let g:startify_list_order = [
    \ ['    MRU files:'],
    \ 'files',
    \ ['    Bookmarks'],
    \ 'bookmarks',
    \ ['    Sessions'],
    \ 'sessions',
    \ ]
nnoremap <silent> <Leader>sr :Startify<CR>
nnoremap <Leader>ss :SSave
nnoremap <Leader>sd :SDelete
nnoremap <Leader>sl :SLoad
nnoremap <Leader>sc :SClose


" =============================================================================
" Deoplete settings
" =============================================================================
let g:deoplete#enable_at_startup = 1


" =============================================================================
" Deoplete-jedi settings
" =============================================================================
let g:deoplete#sources#jedi#show_docstring = 1
let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = '/usr/local/bin/python3.7'


" =============================================================================
" Agit settings
" =============================================================================
nnoremap <silent> <Leader>ag :Agit<CR>


" =============================================================================
" Easy-motion settings
" =============================================================================
let g:EasyMotion_do_mapping = 0             " Disable default mappings
let g:EasyMotion_smartcase = 1              " Turn on case insensitive feature
"nmap <silent> <Leader>j <Plug>(easymotion-j)
"nmap <silent> <Leader>k <Plug>(easymotion-k)
nmap <silent> s <Plug>(easymotion-overwin-f)


" =============================================================================
" Surround settings
" =============================================================================
nmap <silent> <Leader>" ysiw"
nmap <silent> <Leader>' ysiw'
nmap <silent> <Leader>) ysiw)


" =============================================================================
" Augroup, autocmd
" =============================================================================
augroup vimrc_autocmd
    autocmd!

    " Enable emmet for the specific filetypes only
    autocmd FileType html,xml,svg,css,htmldjango,scss,smarty EmmetInstall

    " Apply vimrc changes after an edit
    autocmd BufWritePost ~/.vimrc source ~/.vimrc

    " Return to last edit position when opening files (You want this!)
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Turn on langRunner
    au BufEnter * call LangRunner()

    " Automaticaly close nvim if NERDTree is only thing left open
    au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
