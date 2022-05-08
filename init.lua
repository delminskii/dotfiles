local cmd = vim.cmd
local g = vim.g
local opt = vim.opt
local au = vim.api.nvim_create_autocmd

local hjkl = {'h', 'j', 'k', 'l'}

require('plugins')
require('functions')

local HOME = os.getenv('HOME')

-----------COMMON SETTINGS-----------
cmd([[
filetype plugin indent on
syntax on
]])
opt.autoread = true
opt.number = true
opt.expandtab = true
opt.softtabstop = 4
opt.shiftwidth  = 4
opt.shiftround = true
opt.scrolloff = 4
opt.scrolljump = 4
opt.colorcolumn = '79'

opt.backspace = 'indent,eol,start'
opt.hidden = true
opt.laststatus = 2
opt.display = 'lastline'

opt.completeopt = 'menuone,noinsert,noselect'
opt.wildmode = 'list:longest,full'

opt.showmode = false
opt.showcmd = true

opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true
opt.suffixesadd = '.py,.txt'

opt.autochdir = true

-- Encodings
opt.ffs = 'unix,dos,mac'
opt.fencs = 'utf-8,cp1251,koi8-r,ucs-2,cp866'
opt.listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
opt.lazyredraw = true

opt.splitbelow = true
opt.splitright = true

opt.cursorline = true
opt.wrapscan = true
opt.wrap = true
opt.report = 0
opt.synmaxcol = 200
opt.tw = 79
opt.termguicolors = true

-- disable change of curso shape
opt.guicursor = ''

opt.directory = HOME .. '/.vim/files/swap//'
g.python_host_prog = '/usr/bin/python2.7'
g.python3_host_prog = '/usr/bin/python3.7'

-- Colorscheme settings
g.gruvbox_italicize_strings = 0
local hour = tonumber(os.date('%H'))
opt.bg = hour >= 7 and hour < 19 and 'light' or 'dark'
cmd('colorscheme gruvbox8_soft')

-- Visual mode pressing * or # searches for the current selection;
map('v', '*', [[<CMD><C-u>call general#VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>]])
map('v', '#', [[<CMD><C-u>call general#VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>]])

-- Increase/decrease windows' size (up/right +, bot/left -)
map('n', '<up>', '10<C-w>+')
map('n', '<down>', '10<C-w>-')
map('n', '<left>', '10<C-w><')
map('n', '<right>', '10<C-w>>')

-- Clear search-highlight
map('n', '<Leader>/', [[<CMD>nohlsearch<CR>]])

-- Use Ctrl-[hjkl] to select an active split!
for _,v in pairs(hjkl) do
  map('n', string.format('<C-%s>', v), string.format([[<CMD>wincmd %s<CR>]], v))
end

-- Open new blank file
map('n', 'n<C-h>', [[<CMD>lefta vsp new<CR>]])
map('n', 'n<C-j>', [[<CMD>bel sp new<CR>]])
map('n', 'n<C-k>', [[<CMD>abo sp new<CR>]])
map('n', 'n<C-l>', [[<CMD>rightb vsp new<CR>]])

-- Move window <S-A-hjkl>
for _,v in pairs(hjkl) do
  map('n', string.format('<S-M-%s>', v), string.format('<C-W>%s', string.upper(v)))
end

-- <Leader>$n to move to tab$n, $n in [1;9]
for i=1,9 do
  map('n', string.format('<Leader>%i', i), string.format('%igt', i))
end
map('n', '<Leader>0', [[<CMD>tablast<CR>]])
map('n', '<Leader>t', [[<CMD>tabnew<CR>]])
map('n', '<Leader>w', [[<CMD>tabclose<CR>]])

-- Prettify valid JSON contents
map('n', '=j', ':%!python -m json.tool<CR>', {silent = false})
map('v', '=j', ':%!python -m json.tool<CR>', {silent = false})

-- Move a line of text using Alt+[jk]
map('n', '<M-j>', 'mz:m+<cr>`z')
map('n', '<M-k>', 'mz:m-2<cr>`z')
map('v', '<M-j>', [[<CMD>m'>+<cr>`<my`>mzgv`yo`z]])
map('v', '<M-k>', [[<CMD>m'<-2<cr>`>my`<mzgv`yo`z]])

-- Save current buffer into current opened file
map('n', '<F1>', [[<CMD>update<CR>]], {silent = false})

-- Indent shortcut
map('n', '>', '>>')
map('n', '<', '<<')

-- Deprecate skip selection after indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Quickly select the text that was just pasted. This allows you to, e.g.,
-- indent it after pasting.
map('', 'gV', '`[v`]', {silent = false})

-- Remap j and k to act as expected when used on long, wrapped, lines
map('n', 'j', 'gj', {silent = false})
map('n', 'k', 'gk', {silent = false})

-- Nice copying in VIM
map('n', 'Y', 'y$', {silent = false})

-- Nice copying to clipboard
map('v', '<Leader>y', '"+y')

-- Quit
map('n', '<Leader>q', [[<CMD>q<CR>]], {silent = false})
map('n', '<Leader>Q', [[<CMD>q!<CR>]], {silent = false})

-- Leaving insert mode
map('i', 'jk', '<ESC>', {silent = false})

-- better visual til the end$
map('n', 'vE', 'vg_', {silent = false})


-- =============================================================================
-- LSP stuff
-- =============================================================================
vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
map('n', '<Leader>h', [[<CMD>lua vim.lsp.buf.hover()<CR>]])
map('n', '<F2>', [[<CMD>lua vim.lsp.buf.rename()<CR>]])


-- =============================================================================
-- nvim-tree settings
-- =============================================================================
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_add_trailing = 1
map('n', '<Leader>n', [[<CMD>NvimTreeToggle<CR>]])
require('nvim-tree').setup({
  view = {
    mappings = {
      list = {
        -- using <C-s> instead
        {key = '<C-s>', action = 'split'},
        {key = '<C-x>', action = ''},
      }
    }
  },
  git = {
    ignore = true,
    enable = false,
  },
  disable_netrw = true,
  update_focused_file = {enable = true},
  update_cwd = true,
  filters = {dotfiles = true},
})


-- =============================================================================
-- Ale settings
-- =============================================================================
g.ale_fixers = {python = {'black', 'isort'}}
g.ale_fixers['*'] = {'remove_trailing_lines', 'trim_whitespace'}
g.ale_set_highlights = 0
g.ale_fix_on_save = 1
g.ale_linters_explicit = 1
g.ale_linters = {python = {'flake8'}}
g.ale_python_black_options = '-l 79 --fast -t py37'
g.ale_sign_column_always = 1
g.ale_completion_enabled = 0
g.ale_echo_delay = 200
g.ale_sign_error = 'e'
g.ale_sign_warning = 'w'
map('n', '[e', '<Plug>(ale_previous_wrap_error)', {noremap = false})
map('n', ']e', '<Plug>(ale_next_wrap_error)', {noremap = false})
map('n', '[w', '<Plug>(ale_previous_wrap_warning)', {noremap = false})
map('n', ']w', '<Plug>(ale_next_wrap_warning)', {noremap = false})


-- =============================================================================
-- Emmet settings
-- =============================================================================
g.user_emmet_leader_key = '<TAB>'
g.user_emmet_install_global = 0


-- =============================================================================
-- lualine settings
-- =============================================================================
require('lualine').setup{
  options = {
    theme = 'auto',
    section_separators = '',
    component_separators = '',
  },
}


-- =============================================================================
-- Telescope settings
-- =============================================================================
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = require('telescope.themes').get_ivy({
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-[>"] = actions.close,

        -- using C-s instead
        ["<C-x"] = false,
        ["<C-s>"] = actions.select_horizontal,
      }
    },
    prompt_prefix = "🔍",
    file_ignore_patterns = {"output/?.*%.csv", '__pycache__'},
  }),
}
map('n', '<Leader>f', [[<CMD>Telescope git_files<CR>]])
map('n', '<Leader>b', [[<CMD>Telescope buffers<CR>]])
map('n', '<Leader>l', [[<CMD>Telescope live_grep<CR>]])
map('n', '<Leader>;', [[<CMD>Telescope current_buffer_fuzzy_find<CR>]])
map('n', 'gd', [[<CMD>Telescope lsp_definitions<CR>]])


-- =============================================================================
-- Comment.nvim settings
-- =============================================================================
local U = require('Comment.utils')
local A = vim.api
local opt = {silent = true, noremap = true}
require('Comment').setup({
  ignore = '^$',

  ---LHS of toggle mappings in NORMAL + VISUAL mode
  ---@type table
  toggler = {
      ---Line-comment toggle keymap
      line = '<Leader>cc',
  },

  ---LHS of operator-pending mappings in NORMAL + VISUAL mode
  ---@type table
  opleader = {
      ---Line-comment keymap
      line = '<Leader>c',
  },

  ---LHS of extra mappings
  ---@type table
  extra = {
      ---Add comment on the line above
      above = '<Leader>cO',
      ---Add comment on the line below
      below = '<Leader>co',
      ---Add comment at the end of line
      eol = '<Leader>cA',
  },
})

-- https://github.com/numToStr/Comment.nvim/issues/70#issuecomment-998494798
function _G.___gdc(vmode)
 local range = U.get_region(vmode)
 local lines = U.get_lines(range)

 -- Copying the block
 local srow = range.erow
 A.nvim_buf_set_lines(0, srow, srow, false, lines)

 -- Doing the comment
 require('Comment.api').toggle_linewise_op(vmode)

 -- Move the cursor
 local erow = srow + 1
 local line = U.get_lines({ srow = srow, erow = erow })
 local _, col = U.grab_indent(line[1])
 A.nvim_win_set_cursor(0, { erow, col })
end

-- <Leader>dc will do (yank & comment & paste);
-- Example: <Leader>dc3j will copy & comment 4 lines (current+3 below) and
-- paste them after
map('x', '<Leader>dc', [[<ESC><CMD>lua ___gdc(vim.fn.visualmode())<CR>]])
map('n', '<Leader>dc', [[<CMD>set operatorfunc=v:lua.___gdc<CR>g@]])


-- =============================================================================
-- Startify settings
-- =============================================================================
g.startify_session_dir = '~/.vim/session'
g.startify_session_persistence = 1
g.startify_bookmarks = {
    {v = '~/.config/nvim/init.lua'},
    {b = '~/.bashrc'},
    {x = '~/.Xresources'},
    {w = '~/.wgetrc'},
    {s = '~/.ssh/config'},
    {o = '~/.config/openbox/'},
    {t = '~/.tmux.conf'},
    {g = '~/.gitconfig'},
}
g.startify_lists = {
    {type = 'files',        header = {'   MRU Files'}},
    {type = 'bookmarks',    header = {'   Bookmarks'}},
    {type = 'sessions',     header = {'   Sessions'}},
}
map('n', '<Leader>sr', [[<CMD>Startify<CR>]])
map('n', '<Leader>ss', ':SSave<Space>', {silent = false})
map('n', '<Leader>sd', ':SDelete<Space>', {silent = false})
map('n', '<Leader>sl', ':SLoad<Space>', {silent = false})
map('n', '<Leader>sc', ':SClose<Space>', {silent = false})


-- =============================================================================
-- nvim-cmp settings
-- =============================================================================
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args) vim.fn['UltiSnips#Anon'](args.body) end,
  },

  mapping = cmp.mapping.preset.insert(),

  sources = {
    {name = 'nvim_lsp'},
    {name = 'ultisnips'},
    {name = 'buffer'},
  },


  completion = {keyword_length = 2},
  window = {documentation = false},
})
-- Setup lspconfig
require('lspconfig').pylsp.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}


-- =============================================================================
-- hop settings
-- =============================================================================
require('hop').setup()
map('n', 's', [[<CMD>HopChar1<CR>]])


-- =============================================================================
-- Surround settings
-- =============================================================================
for _,br in pairs({'"', "'", ')'}) do
  map('n', '<Leader>' .. br, 'ysiw' .. br, {noremap = false})
  map('n', '<Leader>z' .. br, 'vg_S' .. br .. '<ESC>A,<ESC>', {noremap = false})
end


-- =============================================================================
-- vim-tmux-navigator settings
-- =============================================================================
-- Write current buffer before navigating from vim to tmux pane;
-- cmd('let g:tmux_navigator_save_on_switch = 1')
g.tmux_navigator_save_on_switch = 1


-- =============================================================================
-- vimux settings
-- =============================================================================
g.VimuxHeight = 25
g.VimuxExpandCommand = 1
map('n', '<Leader>vc', [[<CMD>call VimuxPromptCommand()<CR>]])
map('n', '<Leader>vq', [[<CMD>call VimuxCloseRunner()<CR>]])
map('n', '<Leader>vl', [[<CMD>call VimuxClearTerminalScreen()<CR>]])


-- =============================================================================
-- polyglot settings
-- =============================================================================
-- cmd('let g:python_highlight_func_calls = 0')
g.python_highlight_func_calls = 0


-- =============================================================================
-- dadbod settings
-- =============================================================================
-- cmd('let g:db = "sqlite:db.sqlite3"')
g.db = 'sqlite:db.sqlite3'
map('n', '<Leader>db', [[<CMD>DB<CR>]])
map('v', '<Leader>db', [[<CMD>DB<CR>]])


-- ============================================================================
-- ultisnips settings
-- =============================================================================
g.UltiSnipsExpandTrigger = '<tab>'
g.UltiSnipsJumpForwardTrigger = '<tab>'
g.UltiSnipsEditSplit = 'vertical'
g.UltiSnipsSnippetDirectories = {HOME .. '/.vim/user_snippets'}
map('n', '<Leader>ue', [[<CMD>UltiSnipsEdit<CR>]])


-- ============================================================================
-- vim-doge settings
-- =============================================================================
g.doge_python_settings = {single_quotes = 0}


-- ============================================================================
-- goyo settings
-- =============================================================================
map('n', '<Leader>#', [[<CMD>Goyo<CR>]])


-- ============================================================================
-- treesitter settings
-- =============================================================================
require('nvim-treesitter.configs').setup({
  highlight = {enable = {'python'}}
})


-- ============================================================================
-- fugitive settings
-- =============================================================================
cmd([[
function! FugitiveToggle() abort
  try
    exe filter(getwininfo(), "get(v:val['variables'], 'fugitive_status', v:false) != v:false")[0].winnr .. "wincmd c"
  catch /E684/
    Git
    resize 15
  endtry
endfunction
]])
map('n', '<Leader>g', [[<CMD>call FugitiveToggle()<CR>]])


-- =============================================================================
-- Augroup, autocmd
-- =============================================================================
local groupname = 'init_autocmd'
vim.api.nvim_create_augroup(groupname, {clear = true})

-- execute scripts by <Leader>e
local filetypes_executors = {
    python = 'python3.7',
    html = 'firefox-esr -safe-mode -new-window',
    sh = 'bash',
    javascript = 'node',
    ruby = 'ruby',
}
for filetype, executor in pairs(filetypes_executors) do
    au('FileType', {
        desc = 'Executes ' .. filetype .. ' files by <Leader>e',
        group = groupname,
        pattern = filetype,
        command = string.format([[nnoremap <Leader>e <CMD>lua RunWith("%s")<CR>]], executor),
        once = true
    })
end
au('FileType', {
    desc = 'Executes Lua files by <Leader>e',
    group = groupname,
    pattern = 'lua',
    command = [[nnoremap <Leader>e <CMD>w<CR> <CMD>luafile %<CR>]],
    once = true
})
au('FileType', {
    desc = 'Emmet for tags',
    group = groupname,
    pattern = {'html', 'xml', 'css', 'svg', 'htmldjango'},
    command = 'EmmetInstall',
    once = true
})
au('BufWritePost', {
    desc = 'Sources init.lua',
    group = groupname,
    pattern = HOME .. '/.config/nvim/init.lua',
    command = 'source ' .. HOME .. '/.config/nvim/init.lua | PackerCompile',
    once = true
})
au('BufReadPost', {
    desc = 'Returns to last edit position when opening files (You want this!)',
    group = groupname,
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
    once = true
})
au('BufEnter', {
    desc = 'Auto closes nvim tree if it is alone',
    group = groupname,
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    once = true,
    nested = true
})
