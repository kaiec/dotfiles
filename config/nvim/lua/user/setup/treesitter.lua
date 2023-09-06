require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'python',
		'html',
		'javascript',
		'css',
		'scss',
		'vue',
		'markdown',
		'json',
		'turtle',
		'bash',
		'yaml',
		'toml',
		'vim',
		'sparql',
		'bibtex',
		'latex',
		'lua',
	},
	auto_install = true,
	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		disable = { },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true
	},
}

-- Workaround, problems with folding when opening a file
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1469
vim.cmd([[
function FoldConfig()
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
endfunction

autocmd BufAdd,BufEnter,BufNew,BufNewFile,BufWinEnter * :call FoldConfig()
]])


vim.cmd([[
" Folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
]])
