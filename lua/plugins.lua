vim.cmd('packadd packer.nvim')

packer = require('packer')
packer.init({
  max_jobs = 8,
  git = {clone_timeout = 360},
  display = {open_cmd = 'lefta vsp new'}
})

return packer.startup(
function()
  use {'wbthomason/packer.nvim', opt = true}
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use {'junegunn/goyo.vim',  cmd = 'Goyo'}
  use {'mattn/emmet-vim', ft = {'html', 'xml', 'svg'}}
  use 'phaazon/hop.nvim'
  use 'steelsojka/pears.nvim'
  use 'andymass/vim-matchup'
  -- use 'max397574/better-escape.nvim' -- better jk map
  use 'dhruvasagar/vim-table-mode'

  use {'kylechui/nvim-surround', tag = '*'}
  use {'tpope/vim-dadbod', cmd = 'DB'}
  use 'tpope/vim-abolish'
  use 'tpope/vim-unimpaired'
  use 'nvim-lualine/lualine.nvim'
  use 'neovim/nvim-lspconfig'
  -- use {'lifepillar/vim-gruvbox8', cmd = 'neovim'}
  -- use 'Shatur/neovim-ayu'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'ronisbr/nano-theme.nvim'


  use 'Wansmer/treesj'
  use 'dense-analysis/ale'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'numToStr/Navigator.nvim'
  use 'numToStr/FTerm.nvim'
  use { 'kkoomen/vim-doge', run = ':call doge#install()' }
  use 'numToStr/Comment.nvim'
  use 'kyazdani42/nvim-tree.lua'
  use 'mg979/vim-visual-multi'
  use 'mhinz/vim-startify'
  use 'sheerun/vim-polyglot'
  use {'alcesleo/vim-uppercase-sql', ft = {'plsql', 'sql'}}
  use 'lukas-reineke/indent-blankline.nvim'

  -- Telescope
  use 'nvim-lua/plenary.nvim'
  use {'nvim-telescope/telescope.nvim', branch = '0.1.x'}

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  -- Snippets
  use 'SirVer/ultisnips'
  use {'honza/vim-snippets', commit = '4e1d1456fd7d1d5d6cff256578a3e3bbeeb24e62'}

  -- Speedup
  use 'lewis6991/impatient.nvim'

  -- Good colorschemes for me:
  -- use 'mswift42/vim-themes'
  -- `afterglow` from Plugin 'rafi/awesome-vim-colorschemes'
  -- use 'srcery-colors/srcery-vim'
  -- use 'joshdick/onedark.vim'
  -- use 'w0ng/vim-hybrid'
  -- use 'ajmwagar/vim-deus'
  -- use 'morhetz/gruvbox'
  -- use 'lifepillar/vim-gruvbox8' ^^^
  -- use lifepillar/vim-solarized8
  -- use 'RRethy/nvim-base16' # treesitter suport
  -- use 'haishanh/night-owl.vim'
  -- use 'sjl/badwolf'
  -- use 'rakr/vim-one'
  -- use 'rakr/vim-two-firewatch'
  -- use 'dikiaap/minimalist'
  -- use 'tomasr/molokai'
  -- use 'ajh17/Spacegray.vim'
  -- use 'cocopon/iceberg.vim'
  -- use 'doums/darcula'
  -- use 'kaicataldo/material.vim'
  -- use 'danilo-augusto/vim-afterglow'
  -- use 'mcchrish/zenbones.nvim'
end)
