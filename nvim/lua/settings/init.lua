require("settings.builtin")
require("settings.filetype")
local custom = require("settings.custom")


vim.keymap.set({"n","i"}, "<A-e>", function()
    if custom.texton() then
        custom.notext()
        print("Text mode off.")
    else
        custom.text()
        print("Text mode on!")
    end
end)
