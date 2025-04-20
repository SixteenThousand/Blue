return {
    --- DEPENDENCIES
    "plenary.nvim",
    "nvim-web-devicons",
    {
        dirname = "nvim-treesitter",
        config = function()
            require("plugins.treesitter")
        end,
    },
    --- EXTENSIONS PROPER
    -- colourschemes
    "everforest",
    "catppuccin",
    "kanagawa.nvim",
    "nightfox.nvim",
    "summerfruit256.vim",
    "rose-pine-neovim",
    {
        dirname = "lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    -- note lualine is also mentioned in the <A-r> remap in 
                    -- remap.lua
                    -- 
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = {"filename"},
                    lualine_b = {"branch","diff"},
                    lualine_c = {"diagnostics"},
                    lualine_x = {"fileformat","filesize"},
                    lualine_y = {"progress","filetype","tabs"},
                    lualine_z = {"location"},
                },
            })
        end,
    },
    -- IDE-like stuff
    "nvim-lspconfig",
    "LuaSnip",
    {
        dirname = "Comment.nvim",
        config = function()
            require("Comment").setup()
            local commapi = require("Comment.api")
            -- for some reason, "<C-_>" translates to "Ctrl+/"
            vim.keymap.set({"n","i","v"},"<C-_>",commapi.toggle.linewise.current)
            vim.keymap.set({"n","i","v"},"<C-/>",commapi.toggle.linewise.current)
        end,
    },
    {
        dirname = "nvim-treesitter-textobjects",
        config = function()
            require("plugins.treesitter")
        end,
    },
    "telescope.nvim",
    {
        dirname = "vim-fugitive",
        config = function()
            require("plugins.fugitive")
        end,
    },
    "vim-surround",
    {
        dirname = "vimwiki",
        config = function()
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
