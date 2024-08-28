local lspconfig = require("lspconfig")

lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    -- Disable tsserver's formatting in favor of Prettier or other formatters
    client.server_capabilities.documentFormattingProvider = false
  end,
})
