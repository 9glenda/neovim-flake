-- require "lspconfig"

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
  end
lspconfig.gopls.setup{
on_attach = on_attach_vim,
capabilities = capabilities,
cmd = {"gopls", "serve"},
settings = {
gopls = {
analyses = {
unusedparams = true,
},
staticcheck = true,
linksInHover = false,
codelenses = {
generate = true,
gc_details = true,
regenerate_cgo = true,
tidy = true,
upgrade_depdendency = true,
vendor = true,
},
usePlaceholders = true,
},
},
}
