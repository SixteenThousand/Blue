--- Key Bindings
vim.keymap.set("n","<leader>ee",":buffer ")
vim.keymap.set("n","<leader>ef",":find ")

local bookmarks = {
    ["p"] = "~/Projects",
    ["t"] = "~/Wiki/soon.md",
    ["s"] = "~/Scratch",
}

for key,path in pairs(bookmarks) do
    vim.keymap.set("n","<leader>e"..key, function ()
        vim.cmd.edit(path)
    end)
end


vim.keymap.set("n","-",function ()
	vim.cmd.edit("%:h")
end)

-- tab stuff
vim.keymap.set({"n","i"},"<C-t>",function() vim.cmd.tabnew("%:h") end)
vim.keymap.set("t","<C-t>",vim.cmd.tabnew)
vim.keymap.set({"n","i","t"},"<A-Left>",vim.cmd.tabprev)
vim.keymap.set({"n","i","t"},"<A-Right>",vim.cmd.tabnext)

vim.keymap.set("n", "]b", vim.cmd.bnext)
vim.keymap.set("n", "[b", vim.cmd.bprev)


--- QuickFix List
-- Use :cexpr [] to clear the quickfix list
vim.keymap.set({"n","i"}, "<A-s>", function()
    vim.cmd('caddexpr expand("%").":".line(".").":".getline(".")')
    print("Line added to quickfix list!")
end)
vim.keymap.set("n", "]q", function()
    vim.cmd.cnext()
    vim.cmd.normal("zz")
end)
vim.keymap.set("n", "[q", function()
    vim.cmd.cprev()
    vim.cmd.normal("zz")
end)
-- location list
vim.keymap.set("n", "]l", function()
    vim.cmd.lnext()
    vim.cmd.normal("zz")
end)
vim.keymap.set("n", "[l", function()
    vim.cmd.lprev()
    vim.cmd.normal("zz")
end)

--- Project Navigation
local project_leader = "<leader>j"
vim.keymap.set("n", project_leader.."c", function()
    vim.cmd("Explore .")
end)
vim.keymap.set("n", project_leader.."t", function()
    vim.cmd.edit("TODO.md")
end)
vim.keymap.set("n", project_leader.."s", function()
    local pads = vim.fs.find(
        function(name, _)
            return name:match("^jaeha.*")
        end,
        { type = "file", limit = 3 }
    )
    -- There should only be a source scratchpad file and maybe a compiled 
    -- executable from that file.
    if #pads > 2 then
        vim.api.nvim_err_writeln("Error: Too many jaeha files!")
        return
    end
    -- We want to edit the source file, not the executable.
    if #pads == 2 and vim.fs.basename(pads[1]) == "jaeha" then
        vim.cmd.edit(pads[2])
        return
    end
    if #pads > 0 then
        vim.cmd.edit(pads[1])
        return
    end
    -- If no scratchpad file exists, make one.
    local scratch_dir = vim.fs.joinpath(vim.fn.getcwd(), "scratch")
    vim.fn.mkdir(scratch_dir, "p")
    local scratchpad = vim.fn.input(
[[No scratchpad file detected. Enter an extension below to make one.
No extension will make an executable script.
Ctrl-C will cancel the operation.
]],
        vim.fs.joinpath(scratch_dir, "jaeha.")
    )
    if not vim.fs.basename(scratchpad):match(".*%..*") then
        vim.fn.system(string.format(
            "echo '#!/usr/bin/' > %s && chmod 0777 %s",
            scratchpad,
            scratchpad
        ))
    end
    vim.cmd.edit(scratchpad)
end)
