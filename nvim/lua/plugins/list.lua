return {
    --- DEPENDENCIES
    "plenary.nvim",
    --- EXTENSIONS PROPER
    -- colourschemes
    "everforest",
    "kanagawa.nvim",
    "nightfox.nvim",
    "rose-pine-neovim",
    -- IDE-like stuff
    "nvim-lspconfig",
    {
	    dirname = "telescope.nvim",
	    post = function()
		    require("plugins.telescope")
	    end,
    },
    {
        dirname = "vim-fugitive",
        post = function()
            require("plugins.fugitive")
        end,
    },
    "vim-surround",
}
