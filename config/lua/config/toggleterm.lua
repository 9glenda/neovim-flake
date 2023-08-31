require("toggleterm").setup{
  open_mapping = [[<C-t>]],
  close_on_exit = true, -- close the terminal window when the process exits
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
}

-- Autocommand for TermEnter
-- vim.cmd([[
--   autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
-- ]])

-- Mappings for opening terminals
-- vim.api.nvim_set_keymap('n', '<silent><c-t>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<silent><c-t>', '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })

