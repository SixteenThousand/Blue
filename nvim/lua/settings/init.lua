-- See builtin.lua for more info
vim.g.sxtt_formatoptions =  "tcro/qnb1j"

require("settings.builtin")
require("settings.filetype")
local custom = require("settings.custom")


vim.keymap.set({"n","i"}, "<A-e>", function()
        custom.text()
        print("Text mode on!")
end)
vim.keymap.set({"n","i"}, "<A-S-e>", function()
        custom.notext()
        print("Text mode off.")
end)
