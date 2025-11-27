local cmd = vim.cmd
local g = vim.g
local opt = vim.opt
local au = vim.api.nvim_create_autocmd

local hjkl = {'h', 'j', 'k', 'l'}

require('impatient')
require('plugins')
require('functions')

local HOME = os.getenv('HOME')

-----------COMMON SETTINGS-----------
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

-- opt.completeopt = 'menuone,noinsert,noselect'
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
-- opt.lazyredraw = true

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
g.python_host_prog = './.pyenv/versions/2.7.18/bin/python2.7'
g.python3_host_prog = HOME .. '/.pyenv/versions/3.10.9/bin/python3.10'

-- Colorscheme settings
-- g.gruvbox_italicize_strings = 0
-- local hour = tonumber(os.date('%H'))
-- opt.bg = hour >= 7 and hour < 17 and 'light' or 'dark'
-- cmd(string.format('colorscheme ayu-%s', hour >= 7 and hour < 17 and 'light' or 'dark'))
-- require('catppuccin').setup({
--   styles = {
--     conditionals = {},
--   }
-- })
-- cmd('colorscheme catppuccin')
require("catppuccin").setup({
    no_italic = true,
    no_bold = false,
    no_underline = true
})
vim.cmd.colorscheme "catppuccin"

require("better_escape").setup()


-- =============================================================================
-- FTerm settings
-- =============================================================================
local fterm = require('FTerm')
local fterm_dimensions = {
  height = 0.35,
  width = 1.0,
  y = 1.0
}
fterm.setup({ dimensions = fterm_dimensions })
local runners = {
  python = 'python3',
  html = 'firefox-esr -safe-mode -new-window',
  sh = 'bash',
  javascript = 'node',
  ruby = 'ruby',
  go = 'go run',
}
map('n', '<Leader>e', function()
  cmd('write')
  local buf = vim.api.nvim_buf_get_name(0)
  local ftype = vim.filetype.match({ filename = buf })
  local exec = runners[ftype]
  if exec ~= nil then
    fterm.scratch({
      cmd = { exec, buf },
      dimensions = fterm_dimensions
    })
  end
  end
)
map({'n', 't'}, '<A-i>', fterm.toggle)

-- Visual mode pressing * or # searches for the current selection;
map('v', '*', [[<CMD><C-u>call general#VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>]])
map('v', '#', [[<CMD><C-u>call general#VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>]])

-- Increase/decrease windows' size (up/right +, bot/left -)
map('n', '<up>', '10<C-w>+')
map('n', '<down>', '10<C-w>-')
map('n', '<left>', '10<C-w><')
map('n', '<right>', '10<C-w>>')

-- Clear search-highlight
map('n', '<Leader>/', [[<CMD>lua vim.opt.hlsearch = false<CR>]])

-- Use Ctrl-[hjkl] to select an active split!
for _,v in pairs(hjkl) do
  map('n', ('<C-%s>'):format(v), ([[<CMD>wincmd %s<CR>]]):format(v))
end

-- Open new blank file
map('n', 'n<C-h>', [[<CMD>lefta vsp new<CR>]])
map('n', 'n<C-j>', [[<CMD>bel sp new<CR>]])
map('n', 'n<C-k>', [[<CMD>abo sp new<CR>]])
map('n', 'n<C-l>', [[<CMD>rightb vsp new<CR>]])

-- Move window <S-A-hjkl>
for _,v in pairs(hjkl) do
  map('n', ('<S-M-%s>'):format(v), ('<C-W>%s'):format(v:upper()))
end

-- <Leader>$n to move to tab$n, $n in [1;9]
for i=1,9 do
  map('n', '<Leader>' .. i, i .. 'gt')
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

-- Better switch to command mode
map('n', ';', ':', {silent = false})

-- Better visual til the end$
map('n', 'vE', 'vg_', {silent = false})

-- Type ignore
map('n', '<Leader>mi', ':s/$/\t# type: ignore<CR>')

local function switch_common_sentences()
	local toggles = {
		["true"] = "false",
		["True"] = "False",
		["always"] = "never",
		["yes"] = "no",
    ["debug"] = "dev",
	}

	local cword = vim.fn.expand("<cword>")
	local newWord
	for word, opposite in pairs(toggles) do
		if cword == word then newWord = opposite end
		if cword == opposite then newWord = word end
	end
	if newWord then
		local prevCursor = vim.api.nvim_win_get_cursor(0)
		vim.cmd.normal { '"_ciw' .. newWord, bang = true }
		vim.api.nvim_win_set_cursor(0, prevCursor)
	end
end
map('n', '<Leader>-', switch_common_sentences)


-- =============================================================================
-- LSP stuff
-- =============================================================================
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
vim.diagnostic.config({
  virtual_text = false
})
map('n', '<Leader>i', vim.lsp.buf.hover)
map('n', '<F2>', vim.lsp.buf.rename)


-- =============================================================================
-- nvim-tree settings
-- =============================================================================
local api = require('nvim-tree.api')
map('n', '<Leader>n', api.tree.toggle)
require('nvim-tree').setup({
  on_attach = function(bufnr)
    api.config.mappings.default_on_attach(bufnr)

    -- using <C-s> instead
    vim.keymap.del('n', '<C-x>', { buffer = bufnr })
    map('n', '<C-s>', api.node.open.horizontal, { buffer = bufnr, nowait = true })
  end,
  renderer = {
    highlight_opened_files = "name",
    add_trailing = true
  },
  git = {
    ignore = true,
    enable = true,
  },
  reload_on_bufenter = true,
  disable_netrw = true,
  update_focused_file = {enable = true},
  update_cwd = true,
  filters = {dotfiles = true, exclude = { '__*__' }},
})


-- =============================================================================
-- Ale settings
-- =============================================================================
g.ale_fixers = {
  python = {'ruff_format', 'isort'},
  go = 'gofmt',
  ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
}
g.ale_virtualtext_cursor = 'disabled'
g.ale_set_highlights = 0
g.ale_fix_on_save = 1
g.ale_linters_explicit = 1
g.ale_linters = {python = {'ruff', 'mypy'}, go = {'gopls'}}
g.ale_python_ruff_executable = HOME .. '/.local/bin/ruff'
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
-- vim-table-mode settings
-- =============================================================================
g.vim_table_mode = '+'
g.table_mode_header_fillchar = '='


-- =============================================================================
-- lualine settings
-- =============================================================================
require('lualine').setup{
  options = {
    theme = 'catppuccin',
    -- theme = 'auto',
    -- theme = 'gruvbox',
    -- theme = 'solarized_dark',
    -- theme = 'auto',
    -- theme = '16color',
    section_separators = '',
    component_separators = '',
  },
}


-- =============================================================================
-- Telescope settings
-- =============================================================================
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
require('telescope').setup({
  defaults = require('telescope.themes').get_ivy({
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<Esc>"] = actions.close,

        -- using C-s instead
        ["<C-x"] = false,
        ["<C-s>"] = actions.select_horizontal,
      }
    },
    prompt_prefix = "🔍",
    file_ignore_patterns = {"output/?.*%.csv", '__pycache__'},
  }),
})

local is_inside_work_tree = {}
map('n', '<Leader>f', function()
  local opts = {}
  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end)
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

---- https://github.com/numToStr/Comment.nvim/issues/70#issuecomment-998494798
function _G.___gdc(vmode)
  local range = U.get_region(vmode)
  local lines = U.get_lines(range)

  -- Copying the block
  local srow = range.erow
  A.nvim_buf_set_lines(0, srow, srow, false, lines)

  -- Doing the comment
  require('Comment.api').toggle.linewise(vmode)

  -- Move the cursor
  local erow = srow + 1
  local line = U.get_lines({ srow = srow, erow = erow })
  local _, col, _ = string.find(line[1], '^(%s*)')
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

  preselect = cmp.PreselectMode.None,
  completion = {keyword_length = 2},
  window = {documentation = false},
})

-- Setup lspconfig
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
vim.lsp.config("pylsp", {
  capabilities = capabilities,
  root_markers = { '.git', 'pyproject.toml'},
})
vim.lsp.enable({"pylsp"})
vim.lsp.config("gopls", {capabilities = capabilities})
vim.lsp.enable({"gopls"})


-- =============================================================================
-- hop settings
-- =============================================================================
local hop = require('hop')
hop.setup()
map('n', 's', hop.hint_char1)


-- =============================================================================
-- Surround settings
-- =============================================================================
require('nvim-surround').setup()


-- =============================================================================
-- Navigator settings
-- =============================================================================
local navigator = require('Navigator')
navigator.setup({
  auto_save = nil
})
map('n', "<C-h>", navigator.left)
map('n', "<C-l>", navigator.right)
map('n', "<C-k>", navigator.up)
map('n', "<C-j>", navigator.down)


-- =============================================================================
-- FTerm settings
-- =============================================================================
local fterm = require('FTerm')
local fterm_dimensions = {
  height = 0.35,
  width = 1.0,
  y = 1.0
}
fterm.setup({ dimensions = fterm_dimensions })
local runners = {
  python = 'python3',
  html = 'firefox-esr -safe-mode -new-window',
  sh = 'bash',
  javascript = 'node',
  ruby = 'ruby',
  go = 'go run',
}


-- =============================================================================
-- polyglot settings
-- =============================================================================
-- cm('let g:python_highlight_func_calls = 0')
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
g.doge_python_settings = {single_quotes = 0, omit_redundant_param_types = 0}


-- ============================================================================
-- goyo settings
-- =============================================================================
map('n', '<Leader>#', [[<CMD>Goyo<CR>]])


-- ============================================================================
-- pears.nvim settings
-- =============================================================================
require('pears').setup()


-- ============================================================================
-- treesitter settings
-- =============================================================================
require('nvim-treesitter.configs').setup({
  highlight = {enable = {'python', 'go'}}
})


-- ============================================================================
-- treesj settings
-- =============================================================================
local tsj = require('treesj')
tsj.setup({
    use_default_keymaps = false,
})
map('n', '<Leader>SJ', tsj.toggle)



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
map('n', '<Leader>GP', [[<CMD>Git push -u origin master<CR>]])


-- ============================================================================
-- gitsigns settings
-- =============================================================================
require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr = true, buffer = bufnr})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr = true, buffer = bufnr})

    -- Actions
    local opts = {buffer = bufnr}
    map({'n', 'v'}, '<Leader>hs', ':Gitsigns stage_hunk<CR>', opts)
    map({'n', 'v'}, '<Leader>hr', ':Gitsigns reset_hunk<CR>', opts)
    map('n', '<Leader>hS', gs.stage_buffer, opts)
    map('n', '<Leader>hu', gs.undo_stage_hunk, opts)
    map('n', '<Leader>hR', gs.reset_buffer, opts)
    map('n', '<Leader>hp', gs.preview_hunk, opts)
    map('n', '<Leader>hb', function() gs.blame_line{full=true} end, opts)
    map('n', '<Leader>hB', function() gs.blame() end, opts)
    map('n', '<Leader>tb', gs.toggle_current_line_blame, opts)
    map('n', '<Leader>hd', gs.diffthis, opts)
    map('n', '<Leader>hD', function() gs.diffthis('~') end, opts)
    map('n', '<Leader>td', gs.toggle_deleted, opts)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts)
  end
})


-- ============================================================================
-- indent_blankline settings
-- =============================================================================
-- '|', '¦', '┆', '┊'
require("ibl").setup({
  enabled = false,
  -- char = '┆'
})
cmd([[highlight IndentBlanklineChar guifg=#a89984 gui=nocombine]])
map('n', '<Leader><Tab>', [[<CMD>IBLToggle<CR>]])


-- ============================================================================
-- parrot settings
-- =============================================================================
require("parrot").setup{
  providers = {
    openrouter = {
      name = "openrouter",
      api_key = os.getenv "OPENROUTER_API_KEY",
      endpoint = "https://openrouter.ai/api/v1/chat/completions",
      models = {
        "x-ai/grok-4.1-fast",
        "openai/gpt-oss-20b:free",
        "kwaipilot/kat-coder-pro:free",
        "qwen/qwen3-coder:free",
        "tngtech/deepseek-r1t2-chimera:free",
        "z-ai/glm-4.5-air:free",
        "tngtech/deepseek-r1t-chimera:free",
        "deepseek/deepseek-chat-v3-0324:free",
        "deepseek/deepseek-r1-0528:free",
        "google/gemma-3-27b-it:free",
        "meta-llama/llama-3.3-70b-instruct:free",
        "deepseek/deepseek-r1:free",
        "google/gemini-2.0-flash-exp:free"
      },
      topic = {
        model = "x-ai/grok-4.1-fast",
        params = { max_completion_tokens = 64 },
      },
      -- params = {
      --   chat = { temperature = 1 },
      --   command = { temperature = 1, top_p = 1 },
      -- },
    },
  },

  user_input_ui = "buffer",
  command_prompt_prefix_template = "Instruction ",
  chat_user_prefix = "### User",
  llm_prefix = "### Assistant",
  chat_free_cursor = true,
  command_auto_select_response = true,
  highlight_response = false,
  chat_shortcut_respond = { modes = { "n" }, shortcut = "<CR>" },
  chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-c>" },
  system_prompt = {
    command = [[
                <context>
                You are an expert programming AI assistant who prioritizes minimalist, efficient code.
                You write idiomatic solutions, seek clarification when needed (via code comments), and accept user preferences even if suboptimal.
                Your responses stricly pertain to the code provided, focused on the snippet in question.
                </context>

                <format_rules>
                - Match the style of user written code
                - Comment sparingly, only to explain large & complex code blocks
                - Always use type annotations on functions when writing python (use 3.12 style builtin types rather than importing from typing)
                </format_rules>

                Respond following these rules. Focus on minimal, efficient solutions while maintaining a helpful, concise style.
            ]],
  },
  hooks = {
            --[[
                            Placeholders
            {{selection}} 	      Current visual selection
            {{filetype}} 	        Filetype of the current buffer
            {{filename}} 	        Filename of the current buffer
            {{filepath}} 	        Full path of the current file
            {{filecontent}} 	    Full content of the current buffer
            {{multifilecontent}} 	Full content of all open buffers
            {{command}} 	        User command (prompt)
            --]]
    RewriteWithContext = function(prt, params)
        local template = [[
                    I have the following code from {{filename}}:

                    ```{{filetype}}
                    {{filecontent}}
                    ```

                    Please look at the following section specifically:
                    ```{{filetype}}
                    {{selection}}
                    ```

                    {{command}}
                    Respond exclusively with the snippet that should replace the selection above.
                ]]
        local model_obj = prt.get_model("command")
        prt.Prompt(params, prt.ui.Target.rewrite, model_obj, "Instruction ", template)
    end,
    ImplementWithContext = function(prt, params)
        local template = [[
                    I have the following code from {{filename}}:

                    ```{{filetype}}
                    {{filecontent}}
                    ```

                    Please look at the following section specifically:
                    ```{{filetype}}
                    {{selection}}
                    ```

                    Please rewrite this according to the contained instructions.
                    Respond exclusively with the snippet that should replace the selection above.
                ]]
        local model_obj = prt.get_model("command")
        prt.Prompt(params, prt.ui.Target.rewrite, model_obj, nil, template)
    end,
    CompleteSelection = function(prt, params)
        local template = [[
                    I have the following code from {{filename}}:

                    ```{{filetype}}
                    {{selection}}
                    ```

                    Please finish the code above carefully and logically. Follow any instructions in the comments.
                    Respond just with the snippet of code that should be inserted.
                ]]
        local model_obj = prt.get_model("command")
        prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
    end,
    Complete = function(prt, params)
        local template = [[
                    I have the following code from {{filename}}:

                    ```{{filetype}}
                    {{filecontent}}
                    ```

                    Please look at the following section specifically and follow any instructions in the comments:
                    ```{{filetype}}
                    {{selection}}
                    ```

                    Please finish the code above carefully and logically.
                    Respond just with the snippet of code that should be inserted.
                ]]
        local model_obj = prt.get_model("command")
        prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
    end,
    CompleteFullContext = function(prt, params)
        local template = [[
                    I have the following code from {{filename}} and other related files:

                    ```{{filetype}}
                    {{multifilecontent}}
                    ```

                    Please look at the following section specifically:
                    ```{{filetype}}
                    {{selection}}
                    ```

                    Please finish the code above carefully and logically.
                    Respond just with the snippet of code that should be inserted.
                ]]
        local model_obj = prt.get_model("command")
        prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
    end,
    ErrorHandling = function(prt, params)
        local template = [[
                    You are a {{filetype}} expert.
                    Review the following code, carefully examine it, and update it to have robust error handling.
                    Prefer to pass errors on to the caller and use minimal try/catch blocks.

                    ```{{filetype}}
                    {{filecontent}}
                    ```
                ]]
        local model_obj = prt.get_model("command")
        prt.logger.info("Adding error handling with: " .. model_obj.name)
        prt.Prompt(params, prt.ui.Target.enew, model_obj, nil, template)
    end,
    Explain = function(prt, params)
        local template = [[
                    Your task is to take the code snippet from {{filename}} and explain it with gradually increasing complexity.
                    Break down the code's functionality, purpose, and key components.
                    The goal is to help the reader understand what the code does and how it works.

                    ```{{filetype}}
                    {{selection}}
                    ```

                    Use the markdown format with codeblocks and inline code.
                    Explanation of the code above:
        ]]
        local model = prt.get_model "command"
        prt.logger.info("Explaining selection with model: " .. model.name)
        prt.Prompt(params, prt.ui.Target.new, model, nil, template)
    end,
    FixBugs = function(prt, params)
        local template = [[
                    You are an expert in {{filetype}}.
                    Fix bugs in the below code from {{filename}} carefully and logically:
                    Your task is to analyze the provided {{filetype}} code snippet, identify
                    any bugs or errors present, and provide a corrected version of the code
                    that resolves these issues. Explain the problems you found in the
                    original code and how your fixes address them. The corrected code should
                    be functional, efficient, and adhere to best practices in
                    {{filetype}} programming.

                    ```{{filetype}}
                    {{selection}}
                    ```

                    Fixed code:
        ]]
        local model_obj = prt.get_model "command"
        prt.logger.info("Fixing bugs in selection with model: " .. model_obj.name)
        prt.Prompt(params, prt.ui.Target.new, model_obj, nil, template)
    end,
    Optimize = function(prt, params)
        local template = [[
                    You are an expert in {{filetype}}.
                    Your task is to analyze the provided {{filetype}} code snippet and
                    suggest improvements to optimize its performance. Identify areas
                    where the code can be made more efficient, faster, or less
                    resource-intensive. Provide specific suggestions for optimization,
                    along with explanations of how these changes can enhance the code's
                    performance. The optimized code should maintain the same functionality
                    as the original code while demonstrating improved efficiency.

                    ```{{filetype}}
                    {{selection}}
                    ```

                    Optimized code:
        ]]
        local model_obj = prt.get_model "command"
        prt.logger.info("Optimizing selection with model: " .. model_obj.name)
        prt.Prompt(params, prt.ui.Target.new, model_obj, nil, template)
    end,
  },
}

local opts = {noremap = true}
vim.keymap.set({ "n", "v" }, "<Leader>Pj", ":PrtAppend<CR>", opts)
vim.keymap.set({ "n", "v" }, "<Leader>Pk", ":PrtPrepend<CR>", opts)
vim.keymap.set({ "v" }, "<Leader>Pr", ":PrtRewriteWithContext<CR>", opts)
vim.keymap.set({ "v" }, "<Leader>PR", ":PrtRewrite<CR>", opts)
vim.keymap.set({ "v" }, "<Leader>Pi", ":PrtImplementWithContext<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>Pi", "V:PrtImplementWithContext<CR>", opts)
vim.keymap.set({ "v" }, "<Leader>PI", ":PrtImplement<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>PI", "V:PrtImplement<CR>", opts)
vim.keymap.set({ "v" }, "<Leader>Pe", ":PrtEdit<CR>", opts)
vim.keymap.set({ "v" }, "<Leader>Pc", ":PrtComplete<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>Pc", "V:PrtComplete<CR>", opts)
vim.keymap.set({ "v" }, "<Leader>Ps", ":PrtCompleteSelection<CR>", opts)
vim.keymap.set({ "v" }, "<Leader>PC", ":PrtCompleteFullContext<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>PC", "V:PrtCompleteFullContext<CR>", opts)
vim.keymap.set({ "n", "v" }, "<Leader>Pt", ":PrtChatToggle<CR>", opts)
vim.keymap.set({ "n", "v" }, "<Leader>Pn", ":PrtChatNew<CR>", opts)
vim.keymap.set({ "n", "v" }, "<Leader>Pp", ":PrtChatPaste<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>P<CR>", ":PrtChatRespond<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>P?", ":PrtAsk<CR>", opts)


-- =============================================================================
-- Augroup, autocmd
-- =============================================================================
local groupname = 'init_autocmd'
vim.api.nvim_create_augroup(groupname, {clear = true})

au('FileType', {
  desc = 'Emmet for tags',
  group = groupname,
  pattern = {'html', 'xml', 'css', 'svg', 'htmldjango'},
  command = 'EmmetInstall',
})
au('BufWritePost', {
  desc = 'Sources init.lua',
  group = groupname,
  pattern = HOME .. '/.config/nvim/init.lua',
  command = 'source ' .. HOME .. '/.config/nvim/init.lua | PackerCompile',
})
au('BufReadPost', {
  desc = 'Returns to last edit position when opening files (You want this!)',
  group = groupname,
  pattern = '*',
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
  once = true
})
au('BufEnter', {
  desc = 'Auto closes nvim tree if it is alone',
  group = groupname,
  pattern = '*',
  command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
  nested = true
})
