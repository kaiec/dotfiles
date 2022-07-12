local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'
dashboard.section.header.val = {
	[[                               __                ]],
	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {
dashboard.button( "e", "  New file" , ":enew<CR>"),
dashboard.button( "o", "  Open File" , ":Telescope find_files<CR>"),
dashboard.button( "q", "  Quit NVIM" , ":qa<CR>"),
dashboard.button( "c", "  Config" , ":cd ~/.config/nvim<CR>:e init.lua<CR>"),
}
local handle = io.popen('fortune ~/.config/nvim/quotes')
			local fortune = handle:read("*a")
			handle:close()
			-- dashboard.section.footer.val = fortune


dashboard.section.footer.val = require('alpha.fortune')({
	fortune_list = require'user.setup.quotes',
	max_width = 60,
})
dashboard.config.opts.noautocmd = true

vim.cmd[[autocmd User AlphaReady echo 'ready']]

alpha.setup(dashboard.config)
