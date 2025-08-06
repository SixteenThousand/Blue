--- FOLDING SETTINGS
function sixteen_fold_text()
	return "+--- "..(vim.v.foldend-vim.v.foldstart+1).." lines: "..vim.fn.getline(vim.v.foldstart).." ..."
end

--[[
-- Make folds based on patterns for the start & end of each fold.
-- Patterns can included newlines.
-- Lines at the end of the fold can be excluded.
-- 
-- header_pat: string = pattern for start of fold. Vim regex
-- end_pat: string = pattern for end of fold. Vim regex
-- lines_excl: number = number of lines at end of fold to exclude
--]]
function fold_by_pattern(header_pat, end_pat, lines_excl)
    -- show folds next to line numbers
    vim.wo.foldcolumn = "1"
    -- remove exisiting folds & setup cursor
    local start_pos = vim.fn.getpos(".")
    vim.cmd("normal zEgg")
    -- parse arguments
    -- local need_escape = "\\/|"
    -- header_pat = vim.fn.escape(header_pat, need_escape)
    -- end_pat = vim.fn.escape(end_pat, need_escape)
    if not lines_excl then
        lines_excl = 0
    end
    -- find folds
    local header_line = vim.fn.search(header_pat, "cW")
    while header_line ~= 0 do
        local end_line = vim.fn.search(end_pat, "ceW")
        if end_line == 0 then
            vim.cmd(string.format("%d,$fold", header_line))
            break
        else
            vim.cmd(string.format(
                "%d,%dfold",
                header_line,
                end_line - lines_excl
            ))
        end
        header_line = vim.fn.search(header_pat, "cW")
    end
    -- reset cursor
    vim.fn.setcursorcharpos(start_pos)
end

function wipe_folds()
    vim.wo.foldmethod = "manual"
    vim.cmd.normal("zE") -- deletes all folds
    vim.wo.foldcolumn = "0"
end
        
vim.wo.foldcolumn = "0"
vim.go.foldtext = "v:lua.sixteen_fold_text()"
vim.opt_global.fillchars:append{ fold = " " }

-- stop folds being highlighted
vim.cmd("highlight Folded guibg=bg")
vim.api.nvim_create_autocmd("ColorScheme",{
    callback = function()
		vim.cmd("highlight Folded guibg=bg")
    end,
})


vim.api.nvim_create_user_command(
	"Fold",
    function(opts)
        local cmd = opts.fargs[1]
        if cmd == "?" or cmd == "help" then
            print([[py
 c
 lua]])
            return
        end
        if cmd == "py" then
            fold_by_pattern("^\\S", "\\n\\n\\n", 2)
        elseif cmd == "c" then
            fold_by_pattern([[^\S.*[({[]$]], "^[])}]$")
        elseif cmd == "lua" then
            fold_by_pattern([[^\S]], "^end$")
        end
    end,
    {nargs="*"}
)
vim.keymap.set("n", "<A-f>", function()
    fold_by_pattern([[^\S.*[({[]$]], "^[])}]$")
end)
vim.keymap.set("n", "<A-S-f>", wipe_folds)
