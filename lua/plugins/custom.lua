return {
  -- nvim-cmp (Auto-completion)
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
      "hrsh7th/cmp-path", -- Path source for nvim-cmp
      "hrsh7th/cmp-cmdline", -- Command-line source for nvim-cmp
      "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
      "L3MON4D3/LuaSnip", -- Snippets plugin
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  -- Prettier (Formatter)
  {
    "prettier/vim-prettier",
    run = "yarn install --frozen-lockfile --production",
    ft = { "javascript", "typescript", "css", "html", "json" },
    config = function()
      vim.cmd([[
        let g:prettier#exec_cmd_async = 1
        let g:prettier#autoformat = 1
        let g:prettier#autoformat_require_pragma = 0
      ]])
    end,
  },

  -- ESLint (Linter)
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
      }
      vim.cmd([[
        augroup Linting
          autocmd!
          autocmd BufWritePost *.js,*.ts,*.jsx,*.tsx lua require('lint').try_lint()
        augroup END
      ]])
    end,
  },

  -- Emmet-vim
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascriptreact", "typescriptreact" },
    config = function()
      vim.g.user_emmet_leader_key = "<C-e>"
    end,
  },

  -- Telescope (Fuzzy Finder)
  {
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules" },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
        },
      })
    end,
  },

  -- Treesitter (Syntax Highlighting and More)
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "javascript", "typescript", "python", "go", "html", "css", "lua" }, -- Add languages you use
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  --  -- Lualine (Statusline)
  --  {
  --    "nvim-lualine/lualine.nvim",
  --    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  --    config = function()
  --      require("lualine").setup({
  --        options = {
  --          theme = "gruvbox",
  --          section_separators = { "", "" },
  --          component_separators = { "", "" },
  --        },
  --      })
  --    end,
  --  },

  -- Git Signs (Git Integration)
  {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup({
        on_attach = function()
          vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "GitGutterAdd" })
          vim.api.nvim_set_hl(0, "GitSignsAddLn", { link = "GitSignsAddLn" })
          vim.api.nvim_set_hl(0, "GitSignsAddNr", { link = "GitSignsAddNr" })
          vim.api.nvim_set_hl(0, "GitSignsChange", { link = "GitGutterChange" })
          vim.api.nvim_set_hl(0, "GitSignsChangeLn", { link = "GitSignsChangeLn" })
          vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "GitSignsChangeNr" })
          vim.api.nvim_set_hl(0, "GitSignsChangedelete", { link = "GitGutterChange" })
          vim.api.nvim_set_hl(0, "GitSignsChangedeleteLn", { link = "GitSignsChangeLn" })
          vim.api.nvim_set_hl(0, "GitSignsChangedeleteNr", { link = "GitSignsChangeNr" })
          vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "GitGutterDelete" })
          vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { link = "GitSignsDeleteLn" })
          vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { link = "GitSignsDeleteNr" })
          vim.api.nvim_set_hl(0, "GitSignsTopdelete", { link = "GitGutterDeleteChange" })
          vim.api.nvim_set_hl(0, "GitSignsTopdeleteLn", { link = "GitSignsDeleteLn" })
          vim.api.nvim_set_hl(0, "GitSignsTopdeleteNr", { link = "GitSignsDeleteNr" })
        end,
      })
    end,
  },

  -- Comment.nvim (Commenting Utility)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Bufferline (Buffer Tabs)
  {
    "akinsho/nvim-bufferline.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("bufferline").setup({})
    end,
  },

  -- Auto Pairs (Auto-close Brackets)
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Which-key (Keybinding Help)
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  },

  -- Trouble (Diagnostics and Quickfix List)
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  },

  -- LSP Saga (Enhanced LSP UI)
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lspsaga").setup({})
    end,
  },
}
