local utils = require("utils")

-- leader/<Plug>/plug key
vim.g.mapleader = " "


-- system copy & paste
vim.keymap.set({"n","v"},"<leader>y","\"+y")
vim.keymap.set({"n","v"},"<leader>p","\"+p")
vim.keymap.set({"n","v"},"<leader>P","\"+P")

-- debug comments
vim.keymap.set("n", "gct", function()
    vim.cmd.normal(string.format("o%s", vim.o.commentstring):format("TODO: "))
    vim.cmd.startinsert({bang=true})
end)
vim.keymap.set("n", "gcT", function()
    vim.cmd.normal(string.format("O%s", vim.o.commentstring):format("TODO: "))
    vim.cmd.startinsert({bang=true})
end)
vim.keymap.set("n", "gcd", function()
    vim.cmd.normal(string.format("A  "..vim.o.commentstring, "debug"))
end)
vim.keymap.set("v", "gcd", function()
    local sel_start = vim.fn.getpos(".")[2]
    local sel_end = vim.fn.getpos("v")[2]
    if sel_start > sel_end then
        local tmp = sel_start
        sel_start = sel_end
        sel_end = tmp
    end
    vim.fn.append(
        math.max(0, sel_start-1),
        string.format(
            utils.indent_string(sel_start)..vim.o.commentstring,
            "debug {{{"
        )
    )
    vim.fn.append(
        sel_end+1,
        string.format(
            utils.indent_string(sel_end+1)..vim.o.commentstring,
            "debug }}}"
        )
    )
end)
vim.keymap.set("n", "gcD", function()
    local debug_start = vim.fn.search("debug {{{$", "bcW")
    if debug_start == 0 then
        return
    end
    vim.cmd.normal("V")
    vim.fn.search("debug }}}$", "W")
end)


-- toggles whether searches are highlighted or not
vim.keymap.set("n","<leader>hh",function()
    vim.go.hlsearch = not vim.go.hlsearch
end)

-- Escaping terminal mode
vim.keymap.set("t","<C-[>","<C-\\><C-N>")
vim.keymap.set("t","<Esc>","<C-\\><C-N>")
vim.keymap.set("t","<C-PageUp>","<C-\\><C-N><C-PageUp>")
vim.keymap.set("t","<C-PageDown>","<C-\\><C-N><C-PageDown>")

-- window stuff
vim.keymap.set({"n","i","t"},"<A-w>",function ()
    local id = vim.fn.win_getid()
    vim.cmd.wincmd("j")
    if vim.fn.win_getid() == id then
        vim.cmd.wincmd("l")
    end
    vim.cmd.quit()
    vim.fn.win_gotoid(id)
end)
vim.keymap.set("n","<C-w>v",function()
    vim.cmd.vsplit(vim.fn.expand("%:h"))
end)
vim.keymap.set("n","<C-w>s",function()
    vim.cmd.split(vim.fn.expand("%:h"))
end)

-- Backspace by a "tab"
local function bs_tab(is_insert)
    local line = vim.fn.getline(".")
    local start_pos = vim.fn.getpos(".")
    local cursor = (is_insert and (start_pos[3]-1)) or (start_pos[3] - 1)
    local before = line:sub(1, cursor)
    local after = line:sub(cursor+1)
    local cutoff = -1-vim.bo.tabstop
    for i=1,vim.bo.tabstop do
        if before:sub(-i,-i) == "\t" then
            cutoff = cutoff + vim.bo.tabstop - 1
        end
    end
    local new_line = before:sub(1, cutoff)..after
    vim.api.nvim_set_current_line(new_line)
    vim.fn.cursor(start_pos[2], #new_line-#after + 1)
end
vim.keymap.set("n", "<A-BS>", bs_tab) 
vim.keymap.set("i", "<A-BS>", function() bs_tab("i") end)

-- Rename the thing under the cursor
vim.keymap.set("n", "<A-8>", "*:%s/<C-r>///gc<Left><Left><Left>")
vim.keymap.set("n", "<A-7>", "*:%s/<C-r>///g<Left><Left>")

-- get path of current buffer
vim.api.nvim_create_user_command(
    "Path",
    function(opts)
        local path
        if vim.bo.filetype == "netrw" then
            path = vim.b.netrw_curdir
        else
            path = vim.fn.expand("%:p")
        end
        if opts.fargs[1] == nil then
            vim.fn.setreg("\"",path)
            print("path yanked to register \"\"")
        else
            vim.fn.setreg(opts.fargs[1],path)
            print("path yanked to register \""..opts.fargs[1])
        end
    end,
    {nargs="?"}
)

-- Ex-mode abbreviations
vim.cmd([[
    cnoreabbrev vm vertical Man
    cnoreabbrev tm tab Man
    cnoreabbrev vh vertical help
    cnoreabbrev th tab help
    cnoreabbrev qq belowright copen
]])
