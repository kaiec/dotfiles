-- Bootstrap Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Helper to load configs
local function c(name)
	return "require('user.setup." .. name .. "')"
end

return require('packer').startup({
	function(use)
		-- Packer can manage itself
		use 'wbthomason/packer.nvim'
		use {
			'nvim-telescope/telescope.nvim',
			requires = {{'nvim-lua/plenary.nvim'}},
			config = c"telescope",
		}
		use {
			'nvim-treesitter/nvim-treesitter',
			run = ':TSUpdate',
			config = c"treesitter",
		}
		use {
			'L3MON4D3/LuaSnip',
			config = c"luasnip",
		}
		-- LSP
		use {
			'neovim/nvim-lspconfig',
			config=c'nvim-lspconfig',
		}
		use {
			'williamboman/nvim-lsp-installer',
			config = c"nvim-lsp-installer",
		}
		-- CMP
		use 'hrsh7th/cmp-nvim-lsp'
		use 'hrsh7th/cmp-buffer'
		use 'hrsh7th/cmp-path'
		use 'saadparwaiz1/cmp_luasnip'
		use {
			"hrsh7th/nvim-cmp",
			config = c"nvim-cmp",
		}
		-- use 'tpope/vim-fugitive' 			-- GIT support
		use {
			'kyazdani42/nvim-tree.lua',
			requires={{'kyazdani42/nvim-web-devicons'}},
			config =  c"nvim-tree",
		}
		-- use 'nelstrom/vim-markdown-folding'		-- Markdown Folding
		-- use 'vim-pandoc/vim-pandoc'		-- Markdown Pandoc
		-- use 'vim-pandoc/vim-pandoc-syntax'		-- Markdown Pandoc
		-- use 'tpope/vim-markdown'       -- Markdown support
		use 'tpope/vim-abolish'       -- Case sensitive replace
		-- use 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
		use 'junegunn/vim-easy-align'  -- Align Markdown Tables and other stuff
		use 'vimwiki/vimwiki'			-- Wiki style markdown
		-- use 'tbabej/taskwiki'			-- Taskwarrior integration
		-- use 'farseer90718/vim-taskwarrior' -- Taskwarriot interface
		-- use 'davidhalter/jedi-vim'			-- auto completion
		-- use 'neoclide/coc.nvim', {'branch': 'release'}			-- auto completion
		use 'mhartington/oceanic-next'		-- color scheme
		-- use 'altercation/vim-colors-solarized'   -- solarized
		use 'dhruvasagar/vim-table-mode'		-- edit tables
		-- use 'vim-syntastic/syntastic'		-- Syntax checker
		use 'sotte/presenting.vim'			-- Presentations
		-- use 'moll/vim-node'				-- Node.js
		-- use 'maksimr/vim-jsbeautify'			-- Javascript Formatting
		use 'junegunn/goyo.vim'			-- Zen mode
		use 'ap/vim-css-color'       -- Hex Color highlighting.
		-- use 'mattn/emmet-vim'       -- HTML auto competion magic.
		use 'ferrine/md-img-paste.vim'       -- Image paste in markdown
		use 'machakann/vim-highlightedyank'   -- Highlight yanked text
		use 'easymotion/vim-easymotion'   -- Easymotion
		use 'tpope/vim-surround' -- Add surrounding parentheses et al.
		use 'tpope/vim-repeat' -- Repeat for surround
		-- use 'jiangmiao/auto-pairs' -- Auto closing of parentheses
		use { 'beauwilliams/focus.nvim',
			config = function()
				require("focus").setup({
					number=false,
					relativenumber=false, 
					hybridnumber=false,
					signcolumn=false,
				})
			end
		}
		-- use 'niklasl/vim-rdf' -- RDF syntax
		-- use 'lervag/vimtex' -- Latex
		-- use 'jpalardy/vim-slime' -- REPL support
		-- use 'jupyter-vim/jupyter-vim' -- Jupyter support
		-- use 'bfredl/nvim-ipy'
		-- use 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
		use {
			'goolord/alpha-nvim',
			requires = { 'kyazdani42/nvim-web-devicons' },
			config = c"alpha",
			branch = "customfortune",
			lock = true,
		}

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require('packer').sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
			return require('packer.util').float({border = 'single'})
			end
		},
		profile = {
			enable = true,
			threshold = 1 -- the amount in ms that a plugins load time must be over for it to be included in the profile
		}
}})
