require("settings.builtin")
require("settings.filetype")
local custom = require("settings.custom")


vim.api.nvim_create_user_command(
    "Collab",
    function(opts)
        custom.collab()
    end,
    {}
)
vim.api.nvim_create_user_command(
    "NoCollab",
    function(opts)
        custom.nocollab()
    end,
    {}
)


-- spellcheck
vim.api.nvim_create_user_command(
	"Spell",
    function()
        vim.wo.spell = true
    end,
	{}
)
vim.api.nvim_create_user_command(
	"NoSpell",
	function ()
        vim.wo.spell = false
	end,
	{}
)

vim.api.nvim_create_user_command(
	"Text",
    custom.text,
	{}
)
vim.api.nvim_create_user_command(
	"NoText",
    custom.notext,
	{}
)

-- changes tab size
vim.api.nvim_create_user_command(
    "SetTabWidth",
    function(opts)
        custom.set_tabwidth(tonumber(opts.fargs[1]))
    end,
    {nargs = 1}
)

-- folding
vim.api.nvim_create_user_command(
	"Fold",
    function(opts)
        local cmd = opts.fargs[1]
        if cmd == "?" or cmd == "help" then
            for k,_ in custom.fold_actions do
                print(k)
            end
        elseif cmd == "header" then
            custom.fold_by_header(opts.fargs[2], opts.fargs[3])
        else
            custom.fold_actions[opts.fargs[1]]()
        end
    end,
    {nargs="*"}
)
