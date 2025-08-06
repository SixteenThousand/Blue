-- Pre-plugin modules
require("misc")
require("settings")
require("nav")
require("terminal")
require("folding")

pcall(require,"plugins")

-- Post-plugin modules
require("amber")
require("colours")
require("lsp")

print("And It Goes On...")
