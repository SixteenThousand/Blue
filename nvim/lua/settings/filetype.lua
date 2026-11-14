local custom = require("settings.custom")

-- HTML/XML-like  languages
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = {
            "css",
            "html",
            "htmldjango",
            "javascript",
            "javascriptreact",
            "vue",
            "php",
            "svg",
            "typescript",
            "typescriptreact",
            "xml",
            "json",
        },
        callback = function()
            custom.set_tabwidth(2)
            custom.tag_mode()
        end,
    }
)

vim.api.nvim_create_autocmd(
    {"BufEnter"},
    {
        pattern = {"*.md"},
        callback = function()
            custom.text()
        end,
    }
)
vim.api.nvim_create_autocmd(
    {"BufLeave"},
    {
        pattern = {"*.md"},
        callback = function()
            custom.notext()
        end,
    }
)
vim.g.filetype_md = "pandoc"
vim.g["pandoc#syntax#conceal#urls"] = 1
vim.g["pandoc#syntax#conceal#blacklist"] = {
    "list",
    "definition",
    "atx",  -- headers
}
