-- telescope.nvim configuration
local tlscp = require("telescope.builtin")
local popup = require("utils.popup")
local utils = require("utils")

vim.keymap.set("n","<leader>ff",function ()
	tlscp.find_files({
		no_ignore = true,
        previewer = false,
	})
end)
vim.keymap.set("n","<leader>fg",function ()
	local scopeRan,_ = pcall(tlscp.git_files,{
		no_ignore = true,
        use_file_path = true,
        previewer = false,
	})
    if not scopeRan then
        vim.cmd.echohl("WarningMsg")
        vim.cmd.echo("\"Not in a git repo (sorry)\"")
        vim.cmd.echohl("None")
    end
end)
vim.keymap.set("n","<leader>fb",function()
    tlscp.buffers({previewer = false})
end)
vim.keymap.set("n","<leader>fh",function()
    tlscp.help_tags({previewer = true})
end)
vim.keymap.set("n","<leader>fq",function()
    tlscp.quickfix({previewer = false})
end)
vim.keymap.set("n","<leader>fl",function()
    tlscp.loclist({previewer = false})
end)
