local custom = require("settings.custom")

-- HTML/XML-like  languages
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = {
            "css",
            "html",
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

-- markdown; the 'spell' option is annoying
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
vim.g.markdown_fenced_languages = {
    "sh",
    "bash=sh",
}
-- Having too many languages in markdown_fenced_languages can slowdown or 
-- break syntax highlighting, so add other languages only when necessary
vim.api.nvim_create_user_command(
    "VWAddSyntax",
    function(opts)
        if bang then
            local index = -1
            for i=1,#vim.g.markdown_fenced_languages do
                if vim.g.markdown_fenced_languages[i] == opts.args[1] then
                    index = i
                    break
                end
            end
            if index ~= -1 then
                table.remove(vim.g.markdown_fenced_languages, index)
            end
        else
            table.insert(vim.g.markdown_fenced_languages, opts.args[1])
        end
    end,
    { nargs = 1, bang = true }
)

-- lisp stuff
vim.g.lisp_rainbow = 1
