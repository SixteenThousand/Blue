-- Load a session, if one is nearby
if vim.fn.argc() == 0 then
    require("amber").setup()
end
