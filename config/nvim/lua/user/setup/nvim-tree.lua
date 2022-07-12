require("nvim-tree").setup({
	update_focused_file = {
		enable=true,
	},	
	view = {
		width = 30,
	},
	renderer = {
		highlight_opened_files='name',
	}
})

vim.cmd("highlight NvimTreeWindowPicker guibg=blue")
    
