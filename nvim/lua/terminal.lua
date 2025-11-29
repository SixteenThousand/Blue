--- +++ Integrated Terminal Settings +++
local utils = require("utils")


--- settings
if utils.is_windows() then
    -- +++ copied from the vim help +++
    -- This section has been copied from the vim help; credit goes to Bram Molenaar
    vim.cmd("let &shell = executable('pwsh') ? 'pwsh' : 'powershell'")
    vim.cmd("let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';'")
    vim.cmd("let &shellredir = '2>&1 | %%{ \"$_\" } | Out-File %s; exit $LastExitCode'")
    vim.cmd("let &shellpipe  = '2>&1 | %%{ \"$_\" } | Tee-Object %s; exit $LastExitCode'")
    vim.cmd("set shellquote= shellxquote=")
    vim.go.shell = "pwsh"
else
    vim.go.shell = "bash"
end

vim.api.nvim_create_autocmd("TermOpen",{
    callback = function(evt)
        vim.wo.scrolloff = 0
    end,
})


--- An Important Utility
-- Creates a new window to the right of the current one, and starts a terminal
-- in that window with a command, if given, and with the currently working 
-- directory being the parent of the current buffer
-- cmd: string; the command to be run by the new terminal.
-- 	Note that you won`t be able to interact with the terminal after the 
-- 	command is run, unless that command starts an interactive process
-- 	(e.g. a REPL) or if this is set to nil, in which case it just opens a 
-- 	terminal
-- focus: boolean; If true, moves the cursor to the new window. Otherwise
-- 	cursor is kept in current window.
function terminal_vsplit(cmd,focus)
	-- first check whether there is already a window to the right of the 
	-- current one
	local startwin = vim.fn.win_getid()
	vim.cmd.wincmd("l")
	if startwin ~= vim.fn.win_getid() then
		-- is this other window a terminal?
		is_term,_ = vim.fn.bufname():find("term://")
		if is_term ~= nil then
            vim.cmd.bdelete()
		end
        vim.fn.win_gotoid(startwin)
    end
    vim.cmd.vsplit()
    vim.cmd.wincmd("l")
	if cmd == "" then
		vim.cmd.terminal()
	else
		vim.cmd.terminal(cmd)
	end
	vim.bo.bufhidden = "delete" -- for luck
	if not focus then
		vim.cmd.wincmd("h")
	end
end


--- Project Recipes
function project_recipe(recipe, use_window)
    local cmd = "make "
    if vim.fn.filereadable(".yona") == 1 then
        cmd = cmd.."-f .yona "
    end
    return cmd..recipe
end

vim.keymap.set({"n","i"}, "<A-t>", function()
    terminal_vsplit(project_recipe("test"))
end)
vim.keymap.set({"n","i"}, "<A-b>", function()
    terminal_vsplit(project_recipe("build"))
end)
vim.keymap.set({"n","i"}, "<A-r>", function()
    terminal_vsplit(project_recipe("run"))
end)

vim.keymap.set({"n","i"}, "<A-S-t>", function()
    vim.cmd("!"..project_recipe("test"))
end)
vim.keymap.set({"n","i"}, "<A-S-b>", function()
    vim.cmd("!"..project_recipe("build"))
end)
vim.keymap.set({"n","i"}, "<A-S-r>", function()
    vim.cmd("!"..project_recipe("run"))
end)


--- yona integration (github.com/SixteenThousand/Yona)
vim.keymap.set({"n","i"},"<A-j>",function()
	vim.cmd("!yona --compile %:p")
end)
vim.keymap.set({"n","i"},"<A-S-j>",function()
	local path = vim.fn.expand("%:h")
	terminal_vsplit("yona --compile "..vim.fn.expand("%:p"))
end)
vim.keymap.set({"n","i"},"<A-k>",function()
	vim.cmd("!yona --run %:p")
end)
vim.keymap.set({"n","i"},"<A-S-k>",function()
	terminal_vsplit("yona --run "..vim.fn.expand("%:p"))
end)
vim.api.nvim_create_user_command(
	"Yona",
	function(opts)
		local yona = "cd "..vim.fn.expand("%:h").." && yona "..opts.fargs[1]
		if opts.bang then
			terminal_vsplit(yona)
		else
			vim.cmd("!"..yona)
		end
	end,
	{nargs=1,bang=true}
)
