local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
  end

local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end


  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gtd', vim.lsp.buf.type_definition, '[G]oto [T]ype [D]efinition')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap

  nmap('<C-K>', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  nmap('<space>ff', function() vim.lsp.buf.format { async = true } end, '[F]ormat [File]')
  -- Create a command `:Format` local to the LSP buffer
  vim.apvim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
  -- Auto format go files
  vim.api.nvim_command("au * BufWritePost <buffer> lua vim.lsp.buf.format()")
  -- vim.api.nvim_command("au FileType go BufWritePost <buffer> lua vim.lsp.buf.format()")



--   function go_org_imports(options, timeout_ms)
--   local context = { source = { organizeImports = true } }
--   vim.validate { context = { context, 't', true } }
--   local params = vim.lsp.util.make_range_params()
--   params.context = context

--   local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
--   print(vim.inspect(result))
--   if not result then return end
--   vim.lsp.util.apply_text_edits(result[1].result)

--   -- local params = vim.lsp.util.make_formatting_params(options)
--   -- local result = vim.lsp.buf_request_sync(0, "textDocument/formatting", params, timeout_ms)
--   -- if not result then return end
--   -- result = result[1].result
--   -- vim.lsp.util.apply_text_edits(result)
-- end

-- vim.api.nvim_command("au BufWritePre *.go lua go_org_imports({}, 1000)")
end


-- local servers = {
--   -- clangd = {},
--   gopls = {
--     cmd = {"gopls", "serve"},
--     settings = {
--       gopls = {
--         semanticTokens = true,
--         analyses = {
--           unusedparams = true,
--           gofumpt = true,
--         },
--         hints = {
--           assignVariableTypes = true,
--           compositeLiteralFields = true,
--           compositeLiteralTypes = true,
--           constantValues = true,
--           functionTypeParameters = true,
--           parameterNames = true,
--           rangeVariableTypes = true,
--         },
--         staticcheck = true,
--         linksInHover = true,
--         codelenses = {
--           generate = true,
--           gc_details = true,
--           regenerate_cgo = true,
--           tidy = true,
--           upgrade_depdendency = true,
--           vendor = true,
--         },
--         usePlaceholders = true,
--       },
--     },
--   },
--   -- pyright = {},
--   rust_analyzer = {},
--   -- tsserver = {},
--   -- html = { filetypes = { 'html', 'twig', 'hbs'} },

--   -- lua_ls = {
--   --   Lua = {
--   --     workspace = { checkThirdParty = false },
--   --     telemetry = { enable = false },
--   --   },
--   -- },
-- }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true



-- Setup neovim lua configuration
require('neodev').setup()


require("lspconfig").gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"@gopls@/bin/gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      linksInHover = true,
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

require("lspconfig").bashls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"@bashls@/bin/bash-language-server", "start"},
  settings = {
  },
}
require('lspconfig').tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"@tsserver@/bin/typescript-language-server", "--stdio"},

}
require'lspconfig'.nixd.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"@nixd@/bin/nixd"},
}
-- for server_name, v in pairs(servers) do
--   require("lspconfig")[server_name].setup = {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = (servers[server_name] or {}).settings,
--       filetypes = (servers[server_name] or {}).filetypes,
--       cmd = (servers[server_name] or {}).cmd,
--   }
-- end
