-- telescope.nvim configuration
require("telescope").setup({
    defaults = {
        layout_config = {
            width = 0.6,
            height = 0.4,
        },
    },
})

local tlscp = require("telescope.builtin")

vim.keymap.set("n","<leader>ff",function ()
	tlscp.find_files({
        search_dirs = { vim.fn.expand("%:h") },
        hidden = true,
		no_ignore = true,
        previewer = false,
	})
end)

-- search in PWD of vim
vim.keymap.set("n", "<leader>fp", function()
	tlscp.find_files({
        hidden = true,
		no_ignore = true,
        previewer = false,
	})
end)

vim.keymap.set("n", "<leader>fg", function()
    tlscp.live_grep({previewer = false})
end)

vim.keymap.set("n", "<leader>ee", function()
    tlscp.buffers({previewer = false})
end)

vim.keymap.set("n", "<leader>fh", function()
    tlscp.help_tags({previewer = true})
end)

vim.keymap.set("n", "<leader>fq", function()
    tlscp.quickfix({previewer = false})
end)

vim.keymap.set("n", "<leader>fl", function()
    tlscp.loclist({previewer = false})
end)
