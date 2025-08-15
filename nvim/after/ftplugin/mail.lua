local custom = require("settings.custom")

custom.text()
custom.set_tabwidth(2)

vim.keymap.set("i", "<C-d>", "<C-n>")
vim.keymap.set("i", "<A-d>", "<C-p>")
