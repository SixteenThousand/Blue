local utils = require("utils")
local M = {}

-- text mode: for editing long blocks of text
-- bug: append cannot take a table of more than 3 things
-- We set formatoptions here manually because I am sick and tired of random
-- plugins adding stuff to formatoptions that breaks vim somehow.
-- conceallevel is set because it's useful for markdown; it should cause no
-- issues in other file formats though.
function M.text()
    vim.bo.formatoptions = vim.g.sxtt_formatoptions.."aw"
    vim.wo.conceallevel = 1
end
function M.notext()
    vim.o.formatoptions = vim.g.sxtt_formatoptions
    vim.cmd([[set conceallevel<]])
end

function M.set_tabwidth(num)
    vim.bo.shiftwidth = num
    vim.bo.tabstop = num
end

-- tag mode: for files which will use xml-like syntax at any point
function M.tag_mode()
    -- lets % toggle between start & end tags
    vim.b.match_words = [[<\(\w\+\)\W:<\/\1]]
    vim.keymap.set(
        "i",
        ">",
        function()
            -- inital state
            local line = vim.fn.getline(".")
            local startpos = vim.fn.getpos(".")
            local line_before_cursor = line:sub(1,startpos[3]-1)
            local line_after_cursor = line:sub(startpos[3])
            -- see if we're at an open tag
            local open_tag = [[^.*<([^/!%s][^>%s]*)[^>]*$]]
            local open_match = line_before_cursor:match(open_tag)
            if open_match ~= nil then
                -- check that we're actually closing a legit HTML tag
                local last_char = line_before_cursor:sub(-1)
                local bad_last_chars = {
                    "/", -- becuase self-closing tags
                    "=", -- becuase react event handlers
                    "?", -- becuase PHP
                }
                for _,char in pairs(bad_last_chars) do
                    if last_char == char then
                        vim.api.nvim_set_current_line(
                            line_before_cursor..">"..line_after_cursor)
                        vim.fn.cursor(startpos[2],startpos[3]+1)
                        return
                    end
                end
                -- close the tag
                vim.api.nvim_set_current_line(string.format(
                    "%s></%s>%s",
                    line_before_cursor,
                    open_match,
                    line_after_cursor
                ))
                vim.fn.cursor(startpos[2],startpos[3]+1)
                return
            end
            -- putting the end tag on a new line
            local close_tag_before = [[<(%S+)[^>]*>$]]
            local close_tag_after = [[^</([^%s>]+)>]]
            local match_before = line_before_cursor:match(close_tag_before)
            local match_after = line_after_cursor:match(close_tag_after)
            if match_before ~= nil and match_before == match_after then
                vim.api.nvim_set_current_line(line_before_cursor)
                vim.fn.append(startpos[2],{
                    utils.indent_string(startpos[2],1),
                    utils.indent_string(startpos[2],0)..line_after_cursor,
                })
                vim.fn.cursor(startpos[2]+1,1)
                vim.fn.cursor(startpos[2]+1,#vim.fn.getline(".")+20)
                return
            end
            vim.api.nvim_set_current_line(
                line_before_cursor..">"..line_after_cursor)
            vim.fn.cursor(startpos[2],startpos[3]+1)
        end,
        {buffer = true}
    )
    vim.keymap.set("i","<M-.>",
        function()
            local line = vim.fn.getline(".")
            local startpos = vim.fn.getpos(".")
            local line_before_cursor = line:sub(1,startpos[3]-1)
            local line_after_cursor = line:sub(startpos[3])
            vim.api.nvim_set_current_line(
                line_before_cursor..">"..line_after_cursor)
            vim.fn.cursor(startpos[2],startpos[3]+1)
        end,
        {buffer = true}
    )
end

return M
