local md_headers_status_ok, md_headers = pcall(require, 'md-headers')
if not md_headers_status_ok then
    return
end

-- Configure the popup window settings.
md_headers.setup {
    width = 60,
    height = 10,
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'}
}

-- Shorten function name.
local keymap = vim.keymap.set
-- Silent keymap option.
local opts = { silent = true }

-- Set keymap.
keymap('n', '<leader>mdh', ':MarkdownHeaders<CR>', opts)
keymap('n', '<leader>mdhc', ':MarkdownHeadersClosest<CR>', opts)
