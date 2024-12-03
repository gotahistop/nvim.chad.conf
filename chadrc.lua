vim.opt.relativenumber = true

vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.diagnostic.config({ virtual_text = false })

---@type ChadrcConfig
local M = {}
M.ui = {
    theme = "chadracula",
    transparency = true
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
