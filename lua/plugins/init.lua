return {{
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
        require "configs.conform"
    end
}, -- These are some examples, uncomment them if you want to see them work!
{
    "neovim/nvim-lspconfig",
    config = function()
        require("nvchad.configs.lspconfig").defaults()
        require "configs.lspconfig"
    end
}, {
    "williamboman/mason.nvim",
    opts = {
        ensure_installed = {"lua-language-server", "stylua", "html-lsp", "css-lsp", "prettier", "rust-analyzer"}
    }
}, {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {"vim", "lua", "vimdoc", "html", "css", "rust"}
    }
}, {
    'mrcjkb/rustaceanvim',
    version = '^4',
    ft = {'rust'}
}, {
    'mfussenegger/nvim-dap',
    config = function()
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end
}, {
    "folke/neodev.nvim",
    opts = {}
}, {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
        require("dapui").setup();
        require("neodev").setup({
            library = {
                plugins = {"nvim-dap-ui"},
                types = true
            }
        })
    end
}}
