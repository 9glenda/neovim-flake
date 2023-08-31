local options = {
  hlsearch = false, -- search
  mouse = 'a', -- mouse

  ignorecase = true,
  smartcase = true,

  -- clipboard = 'wl-copy',

  completeopt = {'menuone', 'noselect'}, -- cmd complete

  updatetime = 250,
  timeoutlen = 300,

  undofile = true,
  numberwidth = 4,
}



for k, v in pairs(options) do
  vim.opt[k] = v
end


vim.wo.number = true
vim.wo.relativenumber = true


-- yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})


-- line wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
