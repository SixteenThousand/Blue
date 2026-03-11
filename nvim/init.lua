-- Pre-plugin modules
require("misc")
require("settings")
require("nav")
require("terminal")
require("folding")
require("sessions")

pcall(require,"plugins")
-- Post-plugin modules
require("colours")
require("lsp")

print("And It Goes On...")
