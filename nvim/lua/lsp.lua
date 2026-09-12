local lspconfOn, lspconf = pcall(require, "lspconfig")
if not lspconfOn then
    return
end

--- Servers
lspconf.rust_analyzer.setup{
    cmd = {"rust-analyzer"},
}
lspconf.gopls.setup{}
lspconf.clangd.setup{}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function(evt)
        vim.lsp.start({
            name = "pyrefly",
            cmd = { "pyrefly", "lsp", },
            root_dir = vim.fs.root(evt.buf, ".git"),
        })
    end,
})

--- Get Information & Hover
vim.api.nvim_create_autocmd("LspAttach",{
    callback = function(evt)
        local client = vim.lsp.get_client_by_id(evt.data.client_id)
        -- Turn off the damn semantic highlighting
        client.server_capabilities.semanticTokensProvider = nil
        if client.server_capabilities.hoverProvider then
            vim.keymap.set("n","gh",vim.lsp.buf.hover)
        else
            vim.keymap.set("n","gh",function()
                print("Sorry, this LSP doesn't support hover!")
            end)
        end
        vim.keymap.set("n","gd",vim.lsp.buf.definition,{buffer=true})
        vim.keymap.set("n","gr",vim.lsp.buf.references,{buffer=true})
        vim.keymap.set("n","gn",vim.lsp.buf.rename,{buffer=true})
        vim.keymap.set("n", "gi", vim.lsp.buf.code_action)
        vim.opt_global.completeopt:remove("preview")
    end,
})

vim.keymap.set("n","]e",function()
    vim.diagnostic.goto_next({
        severity = vim.diagnostic.severity.ERROR
    })
end)
vim.keymap.set("n","[e",function()
    vim.diagnostic.goto_prev({
        severity = vim.diagnostic.severity.ERROR
    })
end)
vim.keymap.set("n","]w",function()
    vim.diagnostic.goto_next({
        severity = vim.diagnostic.severity.WARNING
    })
end)
vim.keymap.set("n","[w",function()
    vim.diagnostic.goto_prev({
        severity = vim.diagnostic.severity.WARNING
    })
end)
