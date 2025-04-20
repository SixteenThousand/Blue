-- See lua/plugins/list.lua for more information
-- Reset most vimwiki header key bindings to their defaults...
vim.keymap.set("n", "[[", "<Plug>VimwikiGotoPrevHeader")
vim.keymap.set("n", "]]", "<Plug>VimwikiGoToNextHeader")
vim.keymap.set("n", "[=", "<Plug>VimwikiGoToPrevSiblingHeader")
vim.keymap.set("n", "]=", "<Plug>VimwikiGoToNextSiblingHeader")
vim.keymap.set("n", "]u", "<Plug>VimwikiGoToParentHeader")
vim.keymap.set("n", "]u", "<Plug>VimwikiGoToParentHeader")
-- ... but change some
vim.keymap.set("n", "<leader>,", "<Plug>VimwikiRemoveHeaderLevel")
vim.keymap.set("n", "<leader>.", "<Plug>VimwikiAddHeaderLevel")
