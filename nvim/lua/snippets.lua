local M = {}


M.sixteen_snippets = {}

vim.keymap.set("i", "<C-d>", function()
    if vim.snippet.active({direction=1}) then
        vim.snippet.jump(1)
        return
    end
    local line = vim.fn.getline(".")
    for trigger, snippet in pairs(M.sixteen_snippets) do
        if line:sub(-#trigger) == trigger then
            vim.api.nvim_set_current_line(line:sub(1,-#trigger-1))
            vim.snippet.expand(snippet)
        end
    end
end)


return M
