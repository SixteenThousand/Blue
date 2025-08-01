return {
    --- DEPENDENCIES
    "plenary.nvim",
    "nvim-web-devicons",
    --- EXTENSIONS PROPER
    -- colourschemes
    "everforest",
    "catppuccin",
    "kanagawa.nvim",
    "nightfox.nvim",
    "summerfruit256.vim",
    "rose-pine-neovim",
    -- IDE-like stuff
    "nvim-lspconfig",
    {
        dirname = "LuaSnip",
        post = function()
            require("plugins.luasnip")
        end,
    },
    {
        dirname = "Comment.nvim",
        post = function()
            require("Comment").setup()
            local commapi = require("Comment.api")
            -- for some reason, "<C-_>" translates to "Ctrl+/"
            vim.keymap.set({"n","i","v"},"<C-_>",commapi.toggle.linewise.current)
            vim.keymap.set({"n","i","v"},"<C-/>",commapi.toggle.linewise.current)
        end,
    },
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
    {
        dirname = "vimwiki",
        pre = function()
            vim.g.vimwiki_markdown_link_ext = 1
            vim.g.vimwiki_list = {
                { path = "~/Wiki", syntax = "markdown", ext = ".md", },
            }
        end,
        post = function()
            vim.g.vimwiki_markdown_link_ext = 1
            vim.g.vimwiki_list = {
                {
                    path = "~/Wiki",
                    syntax = "markdown",
                    ext = ".md",
                    diary_frequency = "monthly",
                    auto_toc = 1,
                },
            }
            -- Remove header key bindings so `-` works as normal
            -- See after/ftplugin/markdown.lua for more information
            vim.g.vimwiki_key_mappings = { headers = 0 }
        end,
    },
}
