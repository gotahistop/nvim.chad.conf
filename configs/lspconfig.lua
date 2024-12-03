local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

local servers = { "gopls", "tailwindcss", "eslint", "cssls", "graphql" }

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      analyses = {
        unusedparams = true,
      },
    }
  }
}

lspconfig.yamlls.setup {
    on_attach = function (client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    settings = {
        yaml = {
            format = {
                enable = true,
            },
            schemaStore = {
                enable = true,
            },
        }
    }
}

local function ts_organize_imports()
    vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.api.nvim_buf_get_name(0)}})
end

lspconfig.ts_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        preferences = {
            dissableSuggestions = true,
        },
    },
    commands = {
        OrganizeImports = {
            ts_organize_imports,
            description = "Organize imports",
        }
    }
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end
