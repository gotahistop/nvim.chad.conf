local overrides = require "custom.configs.overrides"

local plugins = {
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "javascript", "javascriptreact", "typescript", "typescriptreact", "html"
        },
        config = function ()
            require("nvim-ts-autotag").setup()
        end
    },
    {
        "akinsho/flutter-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim",
        },
        config = function ()
            local lsp = require "plugins.configs.lspconfig"
            require("flutter-tools").setup {
                decorations = {
                    statusline = {app_version = true, device = true},
                },
                lsp = {
                    on_attach = lsp.on_attach,
                    capabilities = lsp.capabilities,
                    settings = {
                        showTodos = true,
                        completeFunctionCalls = true,
                        updateImportsOnRename = true,
                        lineLength = 120,
                    }
                }
            }
        end,
        ft = "dart",
    },
    {
        "willamboman/mason.nvim",
        opts = {
            ensre_installed = {
                "gopls",

                "pyright",

                "typescript-language-server",
                "tailwindcss-language-server",
                "eslint-lsp",

                "prettier",

                "graphql-language-service-cli",
            },
        }
    },
    {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function()
            local op = require "plugins.configs.treesitter"
            op.ensure_installed = {
                "go",
                "lua",
                "python",
                "javascript",
                "typescript",
                "tsx",
                "css",
            }
            return op
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        ft = "go",
        opts = function ()
            return require "custom.configs.null-ls"
        end
    },
    {
        "mfussenegger/nvim-dap",
        config = function ()
            require "custom.configs.dap"
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = "mfussenegger/nvim-dap",
        config = function ()
            local dap = require("dap")
            local dapui = require("dapui")
            require("dapui").setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end

            dap.listeners.before.event_exited["dapui_config"] = function ()
                dapui.close()
            end
        end
    },
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        dependencies = "mfussenegger/nvim-dap",
        config = function (_, opts)
            require("dap-go").setup(opts)
            require("core.utils").load_mappings("dap_go")
        end
    },
    {
        "olexsmir/gopher.nvim",
        ft = "go",
        config = function (_, opts)
            require("gopher").setup(opts)
        end,
        build = function ()
            vim.cmd [[silent! GoInstallDeps]]
        end
    },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = overrides.copilot,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function ()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 2 },
        { name = "copilot", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path", group_index = 2 },
      },
    },
  },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require('tiny-inline-diagnostic').setup()
        end
    },
}

return plugins
