--local vimwiki_status_ok, vimwiki = pcall(require, "vimwiki")
--if not vimwiki_status_ok then
--  return
--end
vim.g.vimwiki_list = {
  {
    path = "/opt/code/wiki/",
    index = "main",
    syntax = "markdown",
    ext = "md",
    auto_diary_index = 1,
    auto_toc = 1,
    auto_generte_links = 1
  }
}

vim.g.vimwiki_ext2syntax = {
  ['.md'] = 'markdown',
  ['.markdown'] = 'markdown',
  ['.mdown'] = 'markdown',
}

vim.g.vimwiki_markdown_link_ext = 1
vim.g.taskwiki_markup_syntax = 'markdown'
vim.g.markdown_folding = 1
