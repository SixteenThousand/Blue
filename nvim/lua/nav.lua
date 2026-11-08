local bookmarks = {
    ["p"] = "~/Projects",
    ["t"] = "~/Wiki/To-Do.md",
    ["s"] = "~/Scratch",
    ["l"] = "~/Wiki/projects", -- project logs
}

for key, path in pairs(bookmarks) do
    vim.keymap.set("n", "<leader>e"..key, function ()
        vim.cmd.edit(path)
    end)
end

vim.keymap.set("n", "-", function ()
	vim.cmd.edit("%:h")
end)

-- tab stuff
vim.keymap.set({"n", "i"}, "<C-t>", function() vim.cmd.tabnew("%:h") end)
vim.keymap.set("t", "<C-t>", vim.cmd.tabnew)

--- QuickFix List
-- Use :cexpr [] to clear the quickfix list
vim.keymap.set({"n","i"}, "<A-s>", function()
    vim.cmd('caddexpr expand("%").":".line(".").":".getline(".")')
    print("Line added to quickfix list!")
end)
vim.keymap.set("n", "]q", function()
    vim.cmd.cnext()
    vim.cmd.normal("zz")
end)
vim.keymap.set("n", "[q", function()
    vim.cmd.cprev()
    vim.cmd.normal("zz")
end)
-- location list
vim.keymap.set("n", "]l", function()
    vim.cmd.lnext()
    vim.cmd.normal("zz")
end)
vim.keymap.set("n", "[l", function()
    vim.cmd.lprev()
    vim.cmd.normal("zz")
end)
