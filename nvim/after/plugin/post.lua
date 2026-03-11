for _, plugin in ipairs(require("plugins.list")) do
    if plugin.post ~= nil then
        pcall(plugin.post)
    end
end

-- this has to be here instead of in init.lua because otherwise markdown files
-- cannot be opened from sessions without breaking vimwiki features & a really
-- long error message
if vim.fn.argc() == 0 then
    require("sessions").setup()
end
