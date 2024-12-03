local M = {}

M.copilot = {
    i = {
        ["<C-l>"] = {
            function ()
                vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
            end,
            "Copilot accept",
            {
                replace_keycodes = true,
                nowait = true,
                silent = true,
                expr = true,
                noremap = true,
            }
        }
    }
}

M.dap = {
    plugin = true,
    n = {
        ["<leader>db"] = {
            "<cmd> DapToggleBreakpoint <CR>",
            "Add breakpoint to line"
        },
        ["<leader>dus"] = {
            function ()
                local widgets = require("dap.ui.widgets");
                local sidebar = widgets.sidebar(widgets.scope);
                sidebar.open();
            end,
            "Open debugging sidebar"
        }
    }
}

M.dap_go = {
    plugin = true,
    n = {
        ["<leader>dgt"] = {
            function ()
                require("dap-go").debug_test()
            end,
            "Debug go test"
        },
        ["<leader>dgl"] = {
            function ()
                require("dap-go").debug_last()
            end,
            "Debug last go test"
        }
    }
}

vim.keymap.set("n", "gl", vim.diagnostic.open_float)

return M
