vim.wo.number = true
vim.wo.relativenumber = true

vim.keymap.set(
    "n",
    "yy",
    function()
        local line = vim.fn.getline(".")
        if line == "./" then
            line = ""
        end
        vim.fn.setreg(
            "+",
            vim.fs.joinpath(vim.b.netrw_curdir, line)
        )
    end,
    { buffer = true }
)
