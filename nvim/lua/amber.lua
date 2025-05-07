-- this is my own session manager
local M = {}

local utils = require("utils")

local SESS_DIR = vim.fn.stdpath("data").."/amber-sessions"
local SESS_PAT = "(.+)%.amber%.vim"
local SESS_FMT = SESS_DIR.."/%s.amber.vim"
local NO_SESS_OPT = "continue sans session"
local LOCAL_SESS_FILE = "session.amber.vim"

utils.force_exist_dir(SESS_DIR)

function M.get_filepath(name)
	return string.format(SESS_FMT,name)
end

function M.get_amber_files()
	local results = {NO_SESS_OPT}
	for filename,_ in vim.fs.dir(SESS_DIR) do
		_,_,results[#results+1] = filename:find(SESS_PAT)
	end
	return results
end

function M.load(name)
    if name == nil then
        if vim.fn.filewritable(LOCAL_SESS_FILE) == 1 then
        vim.cmd.source(LOCAL_SESS_FILE)
        else
            vim.cmd.echoerr(
                "'No local session file available. Please specify a named session.'"
            )
        end
    elseif name ~= NO_SESS_OPT then
        vim.cmd("%bd!")
		vim.cmd.source(M.get_filepath(name))
	end
end

function M.quit(name)
	if name == NO_SESS_OPT then
		vim.cmd.quitall({bang=true})
	else
		vim.cmd("mksession! "..M.get_filepath(name))
        vim.cmd.quitall({bang=true})
	end
end

function M.save(name)
    if name == nil then
        vim.cmd("mksession! "..LOCAL_SESS_FILE)
        print("You've left a little piece of amber behind you...")
    elseif name ~= NO_SESS_OPT then
		vim.cmd("mksession! "..M.get_filepath(name))
		print("Session <"..name.."> has been preserved in amber!")
	end
end

function M.list()
	local results = ""
	for filename,_ in vim.fs.dir(SESS_DIR) do
		local _,_,session = filename:find(SESS_PAT)
		results = results..session.."\n"
	end
	print(results)
end

function M.wipe(name)
	local fp = io.open(M.get_filepath(name), "w")
	fp:write(":echo 'This session has been wiped'")
	fp:close()
	print("Session <"..name.."> has been wiped!")
end

function M.delete(name)
	os.remove(M.get_filepath(name))
	print("Session <"..name.."> has been deleted entirely!")
end

function M.manage()
    vim.cmd.edit(SESS_DIR)
end

function M.load_local_session()
    local session_path = vim.fn.getcwd().."/.session.vim"
    if vim.fn.filereadable(session_path) == 0 then
        return
    end
    local choice = vim.fn.input(
        "A session file was found. Do you want to load it? (Y/n)? "
    )
    if choice ~= "n" and choice ~= "N" then
        vim.cmd.source(session_path)
    end
    print("\n")
end

function M.save_local_session()
    local session_path = vim.fn.getcwd().."/.session.vim"
    vim.cmd("mksession! "..session_path)
    print(string.format(
        "Session preserved in amber at <<%s>>",
        session_path
    ))
end


--- UI
local subcommands = {
    save = M.save,
    new = M.save,
    list = M.list,
    delete = M.delete,
    wipe = M.wipe,
    load = M.load,
    quit = M.quit,
    manage = M.manage,
}

vim.api.nvim_create_user_command(
    "Amber",
    function(opts)
        if opts.fargs[1] ~= nil then
            subcommands[opts.fargs[1]](opts.fargs[2])
        else
            M.save_local_session()
        end
    end,
    {nargs="*"}
)

vim.keymap.set("n", "<A-S-q>", M.quit)


-- telescope front-end
local utilsOn,popup = pcall(require,"utils.popup")
if utilsOn then
	vim.keymap.set("n","<A-a>",function()
		popup.telescope_dropdown(
			"Amber: Load Session",
			M.get_amber_files(),
			M.load
		)
	end)

	vim.keymap.set("n","<A-q>",function()
		popup.telescope_dropdown(
			"Amber: Quit",
			M.get_amber_files(),
			M.quit
		)
	end)

	vim.keymap.set("n","<A-S-a>",function()
		popup.telescope_dropdown(
			"Amber: Save Session",
			M.get_amber_files(),
			M.save
		)
	end)
end


return M
