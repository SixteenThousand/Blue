-- Pre-plugin modules
require("misc")
require("settings")
require("nav")
require("terminal")

pcall(require,"plugins")

-- Post-plugin modules
require("amber")
require("colours")
require("lsp")

print("And It Goes On...")
