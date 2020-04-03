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
set wildmode=list:longest,full

set noshowmode             " Don't show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set number                 " show numbers

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.
set ignorecase
set smartcase
set showmatch
set suffixesadd=.py,.txt

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

" Visual mode pressing * or # searches for the current selection;
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

" run current script
function RunWith(command)
    :w
    ":call VimuxRunCommand("clear;time " . a:command . " " . expand("%"))
    :call VimuxRunCommandInDir("clear;time " . a:command, 1)
endfunction


" =============================================================================
" plug-vim settings
" =============================================================================
let g:plug_threads = 2

call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim', { 'for': ['html', 'xml', 'svg'] }
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-surround'
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'andrewradev/splitjoin.vim'
Plug 'w0rp/ale'
Plug 'joshdick/onedark.vim'
Plug 'vim-scripts/earendel'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'cohama/agit.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'kkoomen/vim-doge'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-startify'
"Plug 'sheerun/vim-polyglot'
Plug 'alcesleo/vim-uppercase-sql', { 'for': ['plsql', 'sql'] }

" Good colorschemes for me:
" - Plug 'mswift42/vim-themes'
" - `afterglow` from Plugin 'rafi/awesome-vim-colorschemes'
" - Plug 'joshdick/onedark.vim'
" - Plug 'w0ng/vim-hybrid'
" - Plug 'ajmwagar/vim-deus'
" - Plug 'morhetz/gruvbox'
" - Plug 'lifepillar/vim-gruvbox8' ^^^
" - Plug 'chriskempson/base16-vim'
" - Plug 'haishanh/night-owl.vim'
" - Plug 'sjl/badwolf'
" - Plug 'rakr/vim-one'
" - Plug 'rakr/vim-two-firewatch'
" - Plug 'dikiaap/minimalist'
" - Plug 'tomasr/molokai'
" - Plug 'ajh17/Spacegray.vim'
" - Plug 'cocopon/iceberg.vim'
" - Plug 'doums/darcula'

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

" Indent shortcut
nnoremap <silent> > >>
nnoremap <silent> < <<

" Deprecate skip selection after indenting
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" Nice copying
nnoremap Y y$


" =============================================================================
" Nerdtree settings
" =============================================================================
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
\ '\.o$', '\.so$', '\.egg$', '^\.git$', '__pycache__', '\.DS_Store' ]


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
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
nmap <silent> [e <Plug>(ale_previous_wrap_error)
nmap <silent> ]e <Plug>(ale_next_wrap_error)
nmap <silent> [w <Plug>(ale_previous_wrap_warning)
nmap <silent> ]w <Plug>(ale_next_wrap_warning)


" =============================================================================
" Emmet-settings
" =============================================================================
let g:user_emmet_leader_key='<TAB>'
let g:user_emmet_install_global = 0


" =============================================================================
" Colorscheme colors
" =============================================================================
set background=light
"if strftime('%H') >= 7 && strftime('%H') < 19
"  let g:gruvbox_contrast_light='medium'
"  set background=light
"else
"  let g:gruvbox_contrast_dark='medium'
"  set background=dark
"endif
"colorscheme onedark
colorscheme earendel
"highlight clear LineNr


" =============================================================================
" Vim-lightline settings
" =============================================================================
let g:lightline = {
\   'colorscheme': 'one',
\   'separator': { 'left': '⮀', 'right': '⮂' },
\   'subseparator': { 'left': '⮁', 'right': '⮃' }
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
function! FloatingFZF()
    " creates a scratch, unlisted, new, empty, unnamed buffer
    " to be used in the floating window
    let buf = nvim_create_buf(v:false, v:true)

    " 40% of the height
    let height = float2nr(&lines * 0.4)
    " 70% of the height
    let width = float2nr(&columns * 0.7)
    " horizontal position (centralized)
    let horizontal = float2nr((&columns - width) / 2)
    " vertical position (centralized)
    let vertical = float2nr((&lines - height) / 2)

    let opts = {
    \ 'relative': 'editor',
    \ 'row': vertical,
    \ 'col': horizontal,
    \ 'width': width,
    \ 'height': height
    \ }

    " open the new window, floating, and enter to it
    call nvim_open_win(buf, v:true, opts)
endfunction

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

nnoremap <silent> <Leader>rg :Rg<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>gf :GFiles<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>m :Marks<CR>


" =============================================================================
" Nerdcommenter settings
" =============================================================================
let g:NERDDefaultAlign = 'left'


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
    \ {'t': '~/.tmux.conf'},
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
nnoremap <Leader>ss :SSave<Space>
nnoremap <Leader>sd :SDelete<Space>
nnoremap <Leader>sl :SLoad<Space>
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
" easymotion settings
" =============================================================================
let g:EasyMotion_do_mapping = 0             " Disable default mappings
let g:EasyMotion_smartcase = 1              " Turn on case insensitive feature
nmap <silent> s <Plug>(easymotion-overwin-f)


" =============================================================================
" Surround settings
" =============================================================================
nmap <silent> <Leader>" ysiw"
nmap <silent> <Leader>' ysiw'
nmap <silent> <Leader>) ysiw)
nmap <silent> <Leader>} ysiw}


" =============================================================================
" vim-tmux-navigator settings
" =============================================================================
" Write current before before navigating from vim to tmux pane
let g:tmux_navigator_save_on_switch = 1


" =============================================================================
" vimux settings
" =============================================================================
let g:VimuxHeight = "25"
nnoremap <silent> <Leader>vc :call VimuxPromptCommand()<CR>
nnoremap <silent> <Leader>vq :call VimuxCloseRunner()<CR>


" =============================================================================
" Augroup, autocmd
" =============================================================================
augroup vimrc_autocmd
    autocmd!

    " Enable emmet for the specific filetypes only
    autocmd FileType html,xml,css,svg,htmldjango EmmetInstall

    " Apply vimrc changes after an edit
    autocmd BufWritePost ~/.vimrc source ~/.vimrc

    " Return to last edit position when opening files (You want this!)
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Automaticaly close nvim if NERDTree is only thing left open
    au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " run script depends on FileType
    au FileType python nnoremap <Leader>e :call RunWith("python3.7")<CR>
    au FileType html nnoremap <Leader>e :call RunWith("firefox-esr -safe-mode -new-window")<CR>
    au FileType sh nnoremap <Leader>e :call RunWith("bash")<CR>
    au FileType javascript nnoremap <Leader>e :call RunWith("node")<CR>
augroup END
