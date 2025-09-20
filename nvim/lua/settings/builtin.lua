-- default places :find & co will look
vim.opt_global.path = { ".", "", "./**4", "**4", }

-- indentation & autocommenting
vim.go.smarttab = false
-- tab width
vim.o.shiftwidth = 4 -- buffer opt
vim.o.tabstop = 4 -- buffer opt
vim.o.expandtab = true -- buffer opt
vim.opt_local.formatoptions:append("r,o,l")
    -- make vim auto-insert a bunch of comments

-- keeps at least {number} lines beneath the cursor (unless at end of file)
vim.go.scrolloff = 2

-- autosaving
vim.go.autowrite = true
vim.go.autowriteall = true

-- line wrapping/line width
-- allow h & l to take you to a new line
vim.opt_global.whichwrap:append("h,l")
vim.o.wrap = false -- window opt
vim.o.textwidth = 79

-- search stuff, incl. file & buffer search
vim.go.hlsearch = false
vim.go.ignorecase = false
vim.go.fileignorecase = true

-- change what "b" & "w" consider "words"
-- vim.opt_local.iskeyword:remove("_")

-- change what is displayed by the 'list' option
vim.opt_global.listchars = {
	space = "-",
	multispace = "---+",
	tab = "> ",
	nbsp = "+", -- honestly no idea what this one does but it is a default
}

-- getting spellcheck right; buffer option
vim.o.spelllang = "en_gb"

vim.go.showtabline = 0

vim.o.number = true
vim.o.relativenumber = true

vim.go.winborder = "single"

vim.go.splitright = true
vim.go.splitbelow = true

vim.opt_global.sessionoptions:append{
    "localoptions", -- Get syntax highlighting loaded in session load
    "globals", -- Keep my own special settings
}

function SixteenTabs()
    return string.format("tab %d/%d", vim.fn.tabpagenr(), vim.fn.tabpagenr("$"))
end
function SixteenGitInfo()
    local bufPath = vim.fn.expand("%:p")
    local is_not_file = vim.fn.filereadable(bufPath) == 0
    if bufPath == "" or bufPath:match("^%a+://") or is_not_file then
        return ""
    end
    bufPath = vim.uv.fs_realpath(bufPath)
    local cmdOpts = {
        cwd = vim.uv.fs_realpath(vim.fn.expand("%:h")),
        text = true,
    }
    -- Branch
    local branch = ""
    local branchCmdObj = vim.system(
        { "git", "branch", "--show-current", },
        cmdOpts
    ):wait()
    if branchCmdObj.code == 0 then
        branch = branchCmdObj.stdout:sub(1,-2)
    else
        return ""
    end
    -- Changes from index
    local changed = ""
    local changedCmd = {
        "git", "diff", "--exit-code", "--no-patch", bufPath,
    }
    if vim.system(changedCmd, cmdOpts):wait().code ~= 0 then
        changed = "[~]"
    end
    -- Staged status
    local staged = ""
    local stagedCmd = {
        "git",
        "diff",
        "--exit-code",
        "--cached",
        "--no-patch",
        vim.fn.expand("%:p"),
    }
    if vim.system(stagedCmd, cmdOpts):wait().code ~= 0 then
        staged = "[staged]"
    end
    return string.format("git: %s %s%s", branch, changed, staged)
end
vim.opt_global.statusline = [[%t [%n] %m%r%y  %{v:lua.SixteenGitInfo()}%=%<%{v:lua.SixteenTabs()}  %v:%l/%L]]

vim.go.grepformat = "%f:%l,%f:%l%m,%f  %l%m"
vim.go.grepprg = table.concat({
    "grep -RHIn",
    "--exclude-dir .git",
    "--exclude-dir node_modules",
    "--exclude-dir .venv",
    "--exclude tags",
    "--exclude .session.vim",
    "$*"
}, " ")
