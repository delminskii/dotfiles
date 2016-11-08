"
" A (not so) minimal vimrc.
"

" You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
" We set it explicitely to make our position clear!
set nocompatible

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

"let mapleader   ="\<Space>"
"let mapleader   =";"
"nmap <silent> <Space> ;
"vmap <silent> <Space> ;
map <silent> <Space> <Leader>
set cursorline

" omnicompletion settings
set completeopt+=longest,menuone
set completeopt-=preview


" Toggling for paste mode
set pastetoggle =<F2>

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

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

" Toggle Vexplore
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

" !!!!!!!!!!!!!!!!!All below is for ToggleVExplorer which's above!!!!!!!!!!!!!!
" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv         = 1

" absolute width of netrw window
let g:netrw_winsize = -28

" do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" use the previous window to open file
let g:netrw_browse_split = 4
" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


function! LangRunner()
    if(&ft=="python")
        nnoremap <Leader>r :w<cr>:!python %<cr>
    elseif(&ft=="sh")
        nnoremap <Leader>r :w<cr>:!bash %<cr>
    elseif(&ft=="javascript")
        nnoremap <Leader>r :w<cr>:!node %<cr>
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
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'                    " emmet for HTML\CSS
Plugin 'Lokaltog/vim-easymotion'            " easymotion for vim
Plugin 'jiangmiao/auto-pairs'               " auto [({, quotes and so on
"Plugin 'tpope/vim-surround'                " auto-pairs alternative
Plugin 'majutsushi/tagbar'                  " class\module browser
Plugin 'tpope/vim-fugitive'                 " Vim plugin for view current git bunch for vim-airline"
Plugin 'vim-airline/vim-airline'            " Lean & mean status/tabline for vi
Plugin 'vim-airline/vim-airline-themes'     " airline themes
Plugin 'ctrlpvim/ctrlp.vim'                 " fuzzy search (files)"
Plugin 'scrooloose/syntastic'               " linting ANY (!!!) code"
Plugin 'heavenshell/vim-pydocstring'        " python docstring"
Plugin 'scrooloose/nerdcommenter'           " commenting"
Plugin 'gregsexton/MatchTag'                " highlight pairs tags"
Plugin 'godlygeek/tabular'                  " smart tabbing"
Plugin 'terryma/vim-multiple-cursors'       " sublime-like multiple cursors"
Plugin 'triglav/vim-visual-increment'       " inc/dec by C-A/C-X"
Plugin 'morhetz/gruvbox'                    " colorscheme for me"

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
set viminfo     ='100,n$HOME/.vim/files/info/viminfo


" mappings
map <silent> <F3> :call ToggleVExplorer()<CR>

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

" Better scrolling
" nnoremap <C-j> <C-d>
" nnoremap <C-k> <C-u>

" Mappings for tabs
"execute "set <M-1>=\e1"
"execute "set <M-2>=\e2"
"execute "set <M-3>=\e3"
"execute "set <M-4>=\e4"
"execute "set <M-5>=\e5"
"map <silent> <M-1> 1gt
"map <silent> <M-2> 2gt
"map <silent> <M-3> 3gt
"map <silent> <M-4> 4gt
"map <silent> <M-5> 5gt
"map <silent> <c-T> :tabnew<CR>
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


" =============================================================================
" TagBar settings
" =============================================================================
map <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_width = 30
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1


" =============================================================================
" Syntastic setting
" =============================================================================
let g:syntastic_python_checkers = ['flake8']    " also it's possible to add 'python' and other linters
let g:syntastic_python_python_use_codec = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


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

" good themes for me also: hybridline, badwolf, gruvbox, term, base16_chalk,
" simple
let g:airline_theme='base16_chalk'


" =============================================================================
" CtrlP options
" =============================================================================
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_working_path_mode = 'ra'


" =============================================================================
" Pydocstring options
" =============================================================================
nmap <silent> <Leader>d <Plug>(pydocstring)


" =============================================================================
" Auto-pairs options
" =============================================================================
let g:AutoPairsShortcutFastWrap = '<Leader>e'


" =============================================================================
" Easy-motion options
" =============================================================================
map <silent> s <Plug>(easymotion-s)


" =============================================================================
" My custom autocmds
" =============================================================================
augroup vimrc_autocmd
  autocmd!
  autocmd FileType html,xml,svg,css,htmldjango,scss,smarty EmmetInstall

  au BufEnter * call LangRunner()
augroup END
