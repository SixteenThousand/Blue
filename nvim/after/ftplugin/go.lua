vim.bo.expandtab = false
vim.bo.formatprg = "gofmt"

require("snippets").sixteen_snippets = {
    ["boiler"] = [[package $1

import (
    "fmt"$2
)

func $0() {
}]],
}
