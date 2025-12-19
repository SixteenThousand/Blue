vim.bo.expandtab = false

require("snippets").sixteen_snippets = {
    ["boiler"] = [[package $1

import (
    "fmt"$2
)

func $0() {
}]],
}
