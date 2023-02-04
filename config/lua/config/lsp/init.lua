local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
  end

require "config.lsp.gopls"
require "config.lsp.nix"
require "config.lsp.lua"
require "config.lsp.rust"

  -- require "user.lsp.mason"
  -- require("user.lsp.handlers").setup()
--  require "user.lsp.null-ls"
-- lspconfig.gopls.setup {
--     on_attach = on_attach_vim,
--     capabilities = capabilities,
--     cmd = {"gopls", "serve"},
--     settings = {
--         gopls = {
--             analyses = {
--                 unusedparams = true,
--               },
--             staticcheck = true,
--             linksInHover = false,
--             codelenses = {
--                 generate = true,
--                 gc_details = true,
--                 regenerate_cgo = true,
--                 tidy = true,
--                 upgrade_depdendency = true,
--                 vendor = true,
--               },
--             usePlaceholders = true,
--           },
--       },
--   }
