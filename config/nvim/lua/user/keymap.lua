local function map(mode, lhs, rhs, opts)
  local options = { remap = false, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

local autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader=" "


map('n', '<Up>', 'gk')
map('n', '<Down>', 'gj')
map('i', '<Up>', function() return vim.fn.pumvisible() == 1 and '<C-P>' or '<C-O>gk' end, {expr=true})
map('i', '<Down>', function() return vim.fn.pumvisible() == 1 and '<C-N>' or '<C-O>gj' end, {expr=true})


-- COPY / PASTE

-- use last yank
map('n', 'yp', '"0p')
map('n', 'yP', '"0P')
-- foce paste on new line
map('n', 'ygp', 'o<Esc>"0p')
map('n', 'ygP', 'O<Esc>"0p')

-- ctrl-c to copy to system clipboard
map('', '<C-c>', '"+y<CR>')

-- leader y and p to access clipboard
map('n', '<Leader>y', '"+y')
map('n', '<Leader>Y', '"+Y')
map('n', '<Leader>p', '"+p')
map('n', '<Leader>P', '"+P')
-- foce paste on new line
map('n', '<Leader>gp', 'o<Esc>"+p')
map('n', '<Leader>gP', 'O<Esc>"+P')


map('i', '<C-S>', '<esc>:w<cr>')
map('n', '<C-S>', ':w<cr>')
map({'n', '!'}, '<C-BS>', '<C-W>')
map({'!', '!'}, '<C-h>', '<C-w>')
-- noremap <C-Q> <nop>
map('v', '<', '<gv')
map('v', '>', '>gv')

-- reqrap current paragraph without moving cursor
map('n', 'Q', 'gwip')

map('n', '<C-B>', function() require('telescope.builtin').buffers({ignore_current_buffer=true, sort_mru=true}) end)
map('n', '<C-P>', function() require('telescope.builtin').find_files() end)

-- nnoremap <esc> :noh<return><esc> -- clear hlsearch with esc
-- remapping esc leads to strange sideffects in standard vim

-- search current selection
map('v', '//', 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>')

-- esc in terminal to get back to normal mode
map('t', '<Esc>', '<C-\\><C-n>')

-- File tree
-- map('', '<C-n>', ':NERDTreeFind<CR>')
-- map('', '<C-n>', function() return vim.g.NERDTree.IsOpen == 1 and ":NERDTreeClose<CR>" or ":NERDTreeFind<CR>" end, {expr=true})
map('', '<C-n>', ':NvimTreeFindFileToggle<CR>')



-- Notes, Wiki TODO: only activate when in notes
map('n', '<Leader>wn', '<Plug>VimwikiNextLink')
map('n', '<Leader>wp', '<Plug>VimwikiPrevLink')
map('n', '<Leader>wf', '<Plug>VimwikiFollowLink')
map('n', '<Leader>n', ':cd ~/notizen<cr>:e index.md<cr>')
map('n', '<Leader>nn', ':e ~/notizen/scratch.md<CR>Go<CR>### <C-R>=strftime(\'%Y-%m-%d %H:%M:\')<CR>')
map('n', '<Leader>n/', ':cd ~/notizen<cr>:Ag<space>')
-- map('n', '<LEADER>d', ':put=strftime(\'%Y-%m-%d\')<CR>10la')
map('n', '<leader>m', 'yy:terminal ~/dotfiles/mutt/muttjumpwrapper \'<c-r><c-o>"\'<enter>')
map('n', '<leader>t', ':call system("~/dotfiles/bin/vim2task \'" . expand("%:p") ."\'")<enter>:redraw!<enter>')
map('n', '<leader>c', ':let @+=expand("%:p")<CR>')

autocmd("FileType", { 
	pattern="markdown", 
	desc="Enable pasting of images",
	command="nmap <buffer><silent> <leader>i :call mdip#MarkdownClipboardImage()<CR>" 
})
