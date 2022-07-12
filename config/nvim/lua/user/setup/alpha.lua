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

local fortune_list = {
	{
		[[“Without requirements or design, programming is]],
		[[the art of adding bugs to an empty text file.” ]],
		[[- Louis Srygley]],
	},{
		[["One of the best programming skills you can have]],
		[[is knowing when to walk away for awhile."]],
		[[- Oscar Godson]],
	},{
		[["No one in the brief history of computing has ever]],
		[[written a piece of perfect software. It's unlikely]],
		[[that you'll be the first."]],
		[[- Andy Hunt]],
	},{
		[["Every great developer you know got there by]],
		[[solving problems they were unqualified to solve]],
		[[until they actually did it."]],
		[[- Patrick McKenzie]],
	},{
		[["What one programmer can do in one month, two]],
		[[programmers can do in two months."]],
		[[- Fred Brooks]],
	},{
		[["We build our computer (systems) the way we build]],
		[[our cities: over time, without a plan, on top of]],
		[[ruins."]],
		[[- Ellen Ullman]],
	},{
		[["The difference between a bad programmer and a good]],
		[[one is whether they consider their code or their ]],
		[[data structures more important. Bad programmers worry]],
		[[about the code. Good programmers worry about data]],
		[[structures and their relationships."]],
		[[- Linus Torvalds]],
	},
}

dashboard.section.footer.val = require('alpha.fortune')({
	fortune_list = fortune_list,
	max_width = 60,
})
dashboard.config.opts.noautocmd = true

vim.cmd[[autocmd User AlphaReady echo 'ready']]

alpha.setup(dashboard.config)
