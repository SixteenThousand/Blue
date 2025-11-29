--- vim session file management

local SESSION_FILE = ".session.vim"


function load()
    if vim.fn.filereadable(SESSION_FILE) == 0 then
        return
    end
    local choice = vim.fn.input(
        "A session file was found. Do you want to load it? (Y/n)? "
    )
    if choice ~= "n" and choice ~= "N" then
        vim.cmd.source(SESSION_FILE)
    end
    -- This makes the output look better, particularly if something else
    -- is about to be printed.
    print("\n")
end

function save()
    vim.cmd("mksession! "..SESSION_FILE)
    print("Session saved!")
end


vim.keymap.set("n", "<A-q>", function()
    local choice = vim.fn.input(
[[Do you want to preserve this session in amber?
Type anything and hit <Return> to do so:
]])
    if #choice > 0 then
        save()
    end
    vim.cmd.quitall({bang=true})
end)

vim.keymap.set("n", "<A-s>", save)


return {
    setup = function()
        if #vim.fn.bufname(".git/COMMIT_EDITMSG") == 0 then
            load()
        end
    end,
}
