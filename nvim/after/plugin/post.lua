for _, plugin in ipairs(require("plugins.list")) do
    if plugin.post ~= nil then
        pcall(plugin.post)
    end
end
