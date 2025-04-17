function prompt_info {
	local last_status="$?"
	if [[ $last_status -ne 0 ]]
	then
		echo -e "\e[31m=>> $last_status <<=\e[0m"
	fi
    if PROMPT_VCS_INFO=$(git branch --show-current 2>/dev/null)
    then
        PROMPT_VCS_INFO=" $PROMPT_VCS_INFO"
    else
        PROMPT_VCS_INFO=""
    fi
}

PROMPT_COMMAND="prompt_info;${PROMPT_COMMAND#;}"

PS1='\[\e]133;A\e\\\]\[\e]133;P\007\]\
\[\e[33m\]\u\
\[\e[0m\]@\
\[\e[35m\]\H\
\[\e[0m\]+\
\[\e[36m\]bash.v\v\
\[\e[0m\] [\
\[\e[1;34m\]\w\
\[\e[0m\]] <\
\[\e[34m\]\j\
\[\e[0m\]> \
\[\e[3;32m\]$PROMPT_VCS_INFO\
\[\e[0m\]
\[\e[1;31m\] => \[\e[0m\e]133;B\007\]'

PS2='\[\e[1;33m\] -> \[\e[0m\]'
