local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end
lspconfig.rnix.setup({
    on_attach=on_attach,
    settings = {
        ["rnix"] = {
        }
    }
})
