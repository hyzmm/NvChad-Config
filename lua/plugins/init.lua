return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  }, -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp_zero = require "lsp-zero"
      lsp_zero.extend_lspconfig()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "rust-analyzer",
        "typescript-language-server",
        "tailwindcss-language-server",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "vim", "lua", "vimdoc", "html", "css", "rust", "typescript" },
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          node_incremental = "v",
          node_decremental = "V",
        },
      },
    },
  },
  {
    "rust-lang/rust.vim",
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "configs.dap"
    end,
  },
  {
    "folke/neodev.nvim",
    opts = {},
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
      require("neodev").setup {
        library = {
          plugins = { "nvim-dap-ui" },
          types = true,
        },
      }
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup {
        debugger = {
          enabled = true,
          run_via_dap = true,
          exception_breakpoints = {},
          register_configurations = function(paths)
            require("dap").configurations.dart =
              { -- For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
                {
                  name = "Debug Android",
                  request = "launch",
                  type = "dart",
                  args = { "--flavor", "android", "--target", "lib/main_dev.dart" },
                },
                {
                  name = "Debug iOS",
                  request = "launch",
                  type = "dart",
                  args = { "--target", "lib/main_dev.dart" },
                },
              }
          end,
        },
      }
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    --   config = function()
    --     -- require('illuminate').configure({});
    --   end,
  },
  {
    "stevearc/overseer.nvim",
    lazy = false,
    opts = {},
    config = function()
      overseer = require "overseer"
      overseer.setup {}
      overseer.open { direction = "bottom" }
    end,
  },
  {
    "Pocco81/auto-save.nvim",
    lazy = false,
    config = function()
      require("auto-save").setup {}
    end,
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
    config = function()
      require("telescope").load_extension "media_files"
    end,
  },
}
