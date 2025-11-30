require("snippets").sixteen_snippets = {
    ["\\be"] = [[\begin{$1}
    \item $2
\end{$1}]],
    ["boiler"] = [[\documentclass[12pt]{article$1}
$2
\begin{document}
    $3
\end{document}]],
}
