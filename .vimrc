" =============================================================================
" General settings
" =============================================================================
set nocompatible
set backspace=indent,eol,start
set regexpengine=1
"set timeoutlen=120

" ---------------------------------CUSTOM -------------------------------------
" Settings to perform spaces number, which will be replace for \t
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set et                                      " Enable autoreplacement by default
set wrap                                    " Strings' replacement

" Setting to sarching's highlighting & bracket's highlighting
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

" Change directory to the current buffer when opening files.
set autochdir

" Show tabs in the line's beginnings by dots
set listchars=tab:..
set list

" Encodings settings 
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" carriage return sign:

set number
set scrolloff=999                           " offset for scrolling
set nocompatible                            " no compatible with vi
set t_Co=256                                " 256-bit depth color support
set lazyredraw                              " lazy redrawing
set ttyfast

set cursorline
function s:setCursorLine()
    set cursorline
    hi CursorLine ctermbg=black ctermfg=none
    hi Cursor ctermbg=black ctermfg=white
    hi ColorColumn ctermbg=235           " color for the last column
endfunction

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
map <silent> <F3> :call ToggleVExplorer()<CR>


" !!!!!!!!!!!!!!!!!All below is for ToggleVExplorer which's above!!!!!!!!!!!!!!
" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

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

" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" save and execute current python script in shortcut
map ;p :w<CR>:exe ":!python " . getreg("%") . "" <CR>

" save and execute current bash script in shortcut
map ;b :w<CR>:exe ":!bash " . getreg("%") . "" <CR>

" save and execute current js script in shortcut
map ;j :w<CR>:exe ":!node " . getreg("%") . "" <CR>

" clear search-highlight
nmap <silent> ,/ :nohlsearch<CR>

" Toggling for paste mode
set pastetoggle=<F2>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>


" Mappings for tabs
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <c-T> :tabnew<CR>

" =============================================================================
" ADDITIONAL OPTIONS FOR PLUGINS
" =============================================================================
set matchpairs+=<:>                         " additional matchpairs:
set textwidth=79                            " Highlight 80 column
set colorcolumn=+1


" -----------------------------FOR VUNDLE -------------------------------------
filetype plugin indent off
syntax off

" set the runtime path for vundle
set rtp+=~/.vim/bundle/Vundle.vim           " set the runtime path for vundle

" start vundle environment
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" to install a plugin add it here and run :PluginInstall.
" to update the plugins run :PluginInstall! or :PluginUpdate
" to delete a plugin remove it here and run :PluginClean

" YOUR LIST OF PLUGINS GOES HERE LIKE THIS:
Plugin 'mattn/emmet-vim'                    " emmet for HTML\CSS
Plugin 'Lokaltog/vim-easymotion'            " easymotion for vim
Plugin 'jiangmiao/auto-pairs'               " auto [({, quotes and so on
"Plugin 'tpope/vim-surround'                " auto-pairs alternative
Plugin 'majutsushi/tagbar'                  " class\module browser
Plugin 'tpope/vim-fugitive'                 " Vim plugin for view current git bunch for vim-airline
Plugin 'vim-airline/vim-airline'            " Lean & mean status/tabline for vi
Plugin 'vim-airline/vim-airline-themes'     " airline themes
Plugin 'ctrlpvim/ctrlp.vim'                 " fuzzy search (files)
Plugin 'scrooloose/syntastic'               " linting ANY (!!!) code
Plugin 'heavenshell/vim-pydocstring'        " python docstring
Plugin 'scrooloose/nerdcommenter'           " commenting
Plugin 'gregsexton/MatchTag'                " highlight pairs tags
Plugin 'tpope/vim-ragtag'                   " set of personal mappings
Plugin 'godlygeek/tabular'                  " smart tabbing
Plugin 'terryma/vim-multiple-cursors'       " sublime-like multiple cursors
Plugin 'triglav/vim-visual-increment'       " inc/dec by C-A/C-X
Plugin 'nanotech/jellybeans.vim'            " colorscheme for me

Plugin 'MarcWeber/vim-addon-mw-utils'       "
Plugin 'tomtom/tlib_vim'                    "
Plugin 'garbas/vim-snipmate'                " FOR AUTOCOMPLETE
" Optional:                                 "
Plugin 'honza/vim-snippets'                 "

" Plugin 'sjl/badwolf'

call vundle#end()
filetype plugin indent on
syntax on


" =============================================================================
" TagBar settings
" =============================================================================
map <F4> :TagbarToggle<CR>
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
colorscheme jellybeans


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
"
" good themes for me also: hybridline, badwolf, gruvbox, term, base16_chalk
let g:airline_theme='simple'


" =============================================================================
" CtrlP options
" =============================================================================
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_working_path_mode = 'ra'


" =============================================================================
" Pydocstring options
" =============================================================================
nmap <silent> <C-_> <Plug>(pydocstring)     " make docstring for func\class def


" =============================================================================
" Easy-motion options
" =============================================================================
map s <Plug>(easymotion-s)

" =============================================================================
" My custom autocmds
" =============================================================================
augroup vimrc_autocmd
  autocmd!
  autocmd VimEnter * call s:setCursorLine()
  autocmd FileType html,xml,svg,css,htmldjango,scss,smarty EmmetInstall

  " for gnome-terminal
  " toggling cursorline
  autocmd InsertEnter,InsertLeave * set cul!
augroup END


runtime macros/matchit.vim
