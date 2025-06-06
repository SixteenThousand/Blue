local popupOn,popup = pcall(require,"utils.popup")

-- recording the current state so default settings can shared across instances
local COLOUR_SCHEME_FILE = vim.fn.stdpath("config").."/state/colourscheme"
vim.g.sixteen_colourscheme = "sonokai"
local OPACITY_FILE = vim.fn.stdpath("config").."/state/opacity"
vim.g.sixteen_transparency = false
local BACKGROUND_FILE = vim.fn.stdpath("config").."/state/background"
vim.go.background = "dark"


vim.api.nvim_create_autocmd("ColorScheme",{
    callback = function()
        local colourschemeFp = io.open(COLOUR_SCHEME_FILE,"w")
        if colourschemeFp then
            colourschemeFp:write(vim.fn.expand("<amatch>"))
            colourschemeFp:close()
        end
    end,
})

function set_colours()
    if vim.g.neovide then
        if vim.g.sixteen_transparency then
            vim.g.neovide_transparency = 0.95
        else
            vim.g.neovide_transparency = 1
        end
        vim.cmd.colorscheme(vim.g.sixteen_colourscheme)
        return
    end
    if vim.g.sixteen_colourscheme == "everforest" then
        vim.g.everforest_transparent_background = vim.g.sixteen_transparency
    elseif vim.g.sixteen_colourscheme == "sonokai" then
        vim.g.sonokai_transparent_background = vim.g.sixteen_transparency
    elseif vim.g.sixteen_colourscheme:match("^kanagawa") then
        require("kanagawa").setup({
            transparent = vim.g.sixteen_transparency
        })
    elseif vim.g.sixteen_colourscheme:match("^catppuccin") then
        require("catppuccin").setup({
            transparent_background = vim.g.sixteen_transparency
        })
    elseif vim.g.sixteen_colourscheme:match("^material") then
        require("material").setup({
            disable = {
                background = not vim.g.sixteen_transparency
            }
        })
    elseif vim.g.sixteen_colourscheme:match("fox$") then
        require("nightfox").setup({
            options = {
                transparent = vim.g.sixteen_transparency
            }
        })
    elseif vim.g.sixteen_colourscheme:match("^tokyonight") then
        require("tokyonight").setup({
            transparent = vim.g.sixteen_transparency
        })
    else
        if vim.g.sixteen_transparency then
            vim.cmd.colorscheme(vim.g.sixteen_colourscheme)
            vim.api.nvim_set_hl(0, "Normal", { bg="none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg="none" })
            -- TODO: Fix status line bugs that this line causes
            vim.api.nvim_set_hl(0, "EndOfBuffer", { bg="none" })
            return
        end
    end
    vim.cmd.colorscheme(vim.g.sixteen_colourscheme)
end



-- load default opacity
local opacityFp = io.open(OPACITY_FILE,"r")
if opacityFp then
    vim.g.sixteen_transparency = opacityFp:read() == "1"
    opacityFp:close()
end

-- load default background
local backgroundFp = io.open(BACKGROUND_FILE,"r")
if backgroundFp then
    vim.go.background = backgroundFp:read()
    backgroundFp:close()
end

-- load default colourscheme
-- see if there's a state file for it
local colourschemeFp = io.open(COLOUR_SCHEME_FILE,"r")
if colourschemeFp then
    vim.g.sixteen_colourscheme = colourschemeFp:read()
    colourschemeFp:close()
else
    vim.g.sixteen_colourscheme = "zaibatsu"
end
-- check the plugin for the colourscheme has been loaded
local defaultColourSchemeOn,_ = pcall(set_colours)
if not defaultColourSchemeOn then
    vim.g.sixteen_colourscheme = "zaibatsu"
    set_colours()
end

-- key bindings
if popupOn then
    vim.keymap.set("n","<leader>fc",function()
        local before_background = vim.go.background
        popup.telescope_dropdown(
            "Change Colourscheme",
            vim.fn.getcompletion("","color"),
            function(scheme)
                vim.g.sixteen_colourscheme = scheme
                set_colours()
            end
        )
        vim.go.background = before_background
    end)
end
vim.keymap.set("n","<leader>co",function()
    vim.g.sixteen_transparency = not vim.g.sixteen_transparency
    set_colours()
    local opacityFp = io.open(OPACITY_FILE,"w")
    if opacityFp then
        if vim.g.sixteen_transparency then
            opacityFp:write("1")
        else
            opacityFp:write("0")
        end
        opacityFp:close()
    end
end)

-- toggle dark/light mode
vim.keymap.set("n","<leader>cb",function()
    if vim.go.background == "dark" then
        vim.go.background = "light"
    else
        vim.go.background = "dark"
    end
    set_colours()
    local backgroundFp = io.open(BACKGROUND_FILE,"w")
    if backgroundFp then
        backgroundFp:write(vim.go.background)
        backgroundFp:close()
    end
end)
