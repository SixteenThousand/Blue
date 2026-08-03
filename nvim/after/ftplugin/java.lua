require("snippets").sixteen_snippets = {
    ["boiler"] = [[package $1

import $2

public class $3 {
    public static void main(String[] args) {
        $4
    }
}]],
    ["sys"] = [[System.out.println($1);]],
}
