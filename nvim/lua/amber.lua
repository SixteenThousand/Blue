--- My own session manager

local SESS_DIR = vim.fn.stdpath("data").."/amber-sessions"
local SESS_PAT = "(.+)%.amber%.vim"
local SESS_FMT = SESS_DIR.."/%s.amber.vim"
local NO_SESS_OPT = "continue sans session"
local LOCAL_SESS_FILE = "./.session.vim"
-- This is only available if entered manually!
local LOCAL_SESS_OPT = "--local"


function get_session(name)
    if name == LOCAL_SESS_OPT or name == nil then
        if vim.fn.filewritable(LOCAL_SESS_FILE) == 0 then
            vim.api.nvim_err_writeln("Error: No local session!")
            return nil
        end
        return LOCAL_SESS_FILE
    end
    if name == NO_SESS_OPT then
        return nil
    end
    return string.format(SESS_FMT,name)
end

function get_amber_files()
    local results = {NO_SESS_OPT}
    for filename,_ in vim.fs.dir(SESS_DIR) do
        _,_,results[#results+1] = filename:find(SESS_PAT)
    end
    return results
end

function load(name)
    local session = get_session(name)
    if session then
        vim.cmd("%bd!")
        vim.cmd.source(session)
        print([[You crack open the amber to reveal...

work.
:(]])
    end
end

function quit(name)
    local session = get_session(name)
    if session then
        vim.cmd("mksession! "..session)
        vim.cmd.quitall({bang=true})
    else
        vim.cmd.quitall({bang=true})
    end
end

function save(name)
    local session = get_session(name)
    if session then
        vim.cmd("mksession! "..session)
        print("Session <<"..name..">> has been preserved in amber!")
    end
end

function list()
    local results = ""
    for filename,_ in vim.fs.dir(SESS_DIR) do
        local _,_,session = filename:find(SESS_PAT)
        results = results..session.."\n"
    end
    print(results)
end

function wipe(name)
    local session = get_session(name)
    if not session then
        vim.api.nvim_err_writeln("Error: invalid session!")
    end
    local fp = io.open(session, "w")
    fp:write(":echo 'This session has been wiped'")
    fp:close()
    print("Session <<"..name..">> has been wiped!")
end

function delete(name)
    local session = get_session(name)
    if not session then
        vim.api.nvim_err_writeln("Error: invalid session!")
    end
    os.remove(session)
    print("Session <<"..name..">> has been deleted entirely!")
end

function manage()
    vim.cmd.edit(SESS_DIR)
end

function load_local_session()
    if vim.fn.filereadable(LOCAL_SESS_FILE) == 0 then
        return
    end
    local choice = vim.fn.input(
        "A session file was found. Do you want to load it? (Y/n)? "
    )
    if choice ~= "n" and choice ~= "N" then
        vim.cmd.source(LOCAL_SESS_FILE)
    end
    -- This makes the output look better, particularly if something else
    -- is about to be printed.
    print("\n")
end

function save_local_session()
    local LOCAL_SESS_FILE = vim.fn.getcwd().."/.session.vim"
    vim.cmd("mksession! "..LOCAL_SESS_FILE)
    print(string.format(
        "Session preserved in amber at <<%s>>",
        LOCAL_SESS_FILE
    ))
end


--- UI
local subcommands = {
    save = save,
    new = save,
    list = list,
    delete = delete,
    del = delete,
    wipe = wipe,
    load = load,
    quit = quit,
    manage = manage,
}

vim.api.nvim_create_user_command(
    "Amber",
    function(opts)
        if opts.fargs[1] ~= nil then
            subcommands[opts.fargs[1]](opts.fargs[2])
        else
            save_local_session()
        end
    end,
    {nargs="*"}
)

vim.keymap.set("n","<A-a>",function()
    if vim.fn.filereadable(LOCAL_SESS_FILE) > 0 then
        vim.cmd.source(LOCAL_SESS_FILE)
        print("Local session loaded!")
    else
        vim.api.nvim_err_writeln("Error: No local session")
    end
end)
vim.keymap.set("n", "<A-q>", function()
    local choice = vim.fn.input(
[[Do you want to preserve this session in amber?
Type anything and hit <Return> to do so:
]])
    if #choice > 0 then
        save_local_session()
    end
    vim.cmd.quitall({bang=true})
end)

-- telescope front-end
local utilsOn,popup = pcall(require,"utils.popup")
if utilsOn then
    vim.keymap.set("n","<A-S-q>",function()
        popup.telescope_dropdown(
            "Amber: Quit",
            get_amber_files(),
            quit
        )
    end)

    vim.keymap.set("n","<A-S-a>",function()
        popup.telescope_dropdown(
            "Amber: Save Session",
            get_amber_files(),
            save
        )
    end)
end


return {
    setup = function()
        vim.fn.mkdir(SESS_DIR, "p")
        if #vim.fn.bufname(".git/COMMIT_EDITMSG") == 0 then
            load_local_session()
        end
    end,
}
