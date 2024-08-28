return {
  -- Python LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").pyright.setup({})
    end,
    ft = { "python" },
  },

  -- Go LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").gopls.setup({})
    end,
    ft = { "go" },
  },

  -- LaTeX LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").texlab.setup({})
    end,
    ft = { "tex" },
  },

  -- Java LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").jdtls.setup({})
    end,
    ft = { "java" },
  },
}
