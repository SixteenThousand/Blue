--[[
 This my de facto "plugin manager". It works in a similar way to
 [Lazy.nvim](https://github.com/folke/lazy.nvim) in that it adds plugins by
 adding folders to runtimepath.

  A plugin can be installed by cloning its repository into
 stdpath("data")/sixteen-plugins. You can then load it by adding an entry to
 the big table in list.lua. The entry must either be a string, equal to the
 name of its subfolder in sixteen-plugins, or a table, with keys:
     dirname: The name of the plugin's subfolder in sixteen-plugins.
     pre: A function to run before the plugin is loaded.
     post: a function to run after the plugins is loaded. Usually there to 
         load key bindings and the like.
 All files in this folder other than this file and list.lua are just scripts
 loaded by "post" functions.
]]--
local plugin_list = require("plugins.list")

local dirs = {}
for _, plugin in ipairs(plugin_list) do
    local dirname = (type(plugin) == "string" and plugin) or plugin.dirname
    dirs[#dirs+1] = vim.fn.stdpath("data").."/sixteen-plugins/"..dirname
    if plugin.preload then
        plugin.preload()
    end
end

-- Allow system vim plugins to load
vim.opt_global.runtimepath:prepend({
    "/usr/share/vim/vimfiles",
    "/usr/share/vim/vimfiles/after",
})
vim.opt_global.runtimepath:prepend(dirs)
