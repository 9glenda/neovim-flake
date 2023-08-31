-- local opts = {
--   noremap = true,
--   silent = true
-- }

-- local keymap = vim.api.nvim_set_keymap

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true, })
vim.g.mapleader = " "
vim.g.maplocalleader = " "


local xmap = function(keys, func, desc)
  if desc then
    desc = 'Visual: ' .. desc
  end
    vim.keymap.set('x', keys, func, { buffer = bufnr, desc = desc })
end

xmap("J", ":move '>+1<CR>gv-gv", "Move Text")
xmap("K", ":move '<-2<CR>gv-gv", "Move Text")
