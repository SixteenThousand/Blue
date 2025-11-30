-- Pre-plugin modules
require("misc")
require("settings")
require("nav")
require("terminal")
require("folding")
local sessions = require("sessions")

pcall(require,"plugins")
-- Post-plugin modules
require("colours")
require("lsp")

if vim.fn.argc() == 0 then
    sessions.setup()
end
print("And It Goes On...")
