local fuzzyOn,fuzzy = pcall(require,"nav.fuzzy")
require("nav.remaps")
require("nav.quickfix")

-- opens a view on some given buffer(specified as with :buffer) and deletes the 
-- current buffer afterwards ("salting the earth" in its wake)
vim.api.nvim_create_user_command(
    "Salt",
    function(opts)
        -- find out where we are
        local here = vim.fn.bufnr()
        -- find out where we're going & go there
        -- default case
        if opts.fargs[1] == nil then
            vim.cmd.edit(vim.fn.expand("%:h"))
        else
            vim.cmd.buffer(opts.fargs[1])
        end
        -- get rid of original buffer
        vim.cmd.bdelete(here)
    end,
    {nargs="?"}
)


-- scratchpad file
function mkscratch(ext)
    local dir = vim.fn.getenv("HOME").."/Temp"
    local scratch_dir = vim.fn.getcwd().."/scratch"
    if vim.fn.isdirectory(scratch_dir) > 0 then
        dir = scratch_dir
    end
    local file = dir.."/jaeha"
    if ext == nil then
        local ext = vim.fn.input(string.format(
            "Creating file (leave empty for no extension) %s.",
            file
        ))
    end
    if #ext > 0 then
        file = file.."."..ext
    elseif vim.fn.filereadable(file) == 0 then
        vim.fn.system(string.format(
            "echo '#!/usr/bin/' > %s && chmod 0777 %s",
            file,
            file
        ))
    end
    vim.cmd.edit(file)
end

vim.keymap.set("n", "<leader>es", mkscratch)
vim.api.nvim_create_user_command(
    "Scratch",
    function(opts)
        if #opts.fargs > 0 then
            mkscratch(opts.fargs[1])
        else
            mkscratch("")
        end
    end,
    {nargs="?"}
)
