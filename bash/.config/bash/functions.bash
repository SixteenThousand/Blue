# scripts that either can't be separate files or are just too small to be

function book {
    local old_dir=$PWD
    cd ~/Documents/Books-and-Things
    local book=$(fzf)
    if [[ -n "$book" ]]
    then
        local url="file://${PWD}/${book}" 
        case $1 in
            -p|--print)
                printf "$url"
                ;;
            *)
                xdg-open "$url" & disown
                ;;
        esac
    else
        echo "You don't like reading, do you?" >&2
    fi
    cd $old_dir
}

function stale {
	# choose something
	case $1 in
		-h|--help)
			cat <<- EOF
			stale, a shell history management tool
			
			Usage:
			    stale (no arguments)
			Fuzzy find a command in bash's history to run again
			    stale DIGIT
			Add command -DIGIT to bookmarks
			    stale -e|--edit
			Edit list of bookmarked commands in \$EDITOR
			    stale -b|--bookmarks
			Run a bookmarked command
			EOF
			return
			;;
		-e|--edit)
			$EDITOR "$SIXTEEN_DATA_DIR/stale-bookmarks" "$SIXTEEN_DATA_DIR/.bash_history"
			return
			;;
		-b|--bookmarks)
			local stale_cmd=$(cat "$SIXTEEN_DATA_DIR/stale-bookmarks" | \
				fzf --prompt='stale bookmark> ')
			;;
		?*)
			# add command -DIGIT to bookmarks
			local stale_cmd=$(fc -ln "-$1" "-$1")
            stale_cmd=$(echo "$stale_cmd" | sed 's/^\s*//')
			echo -e "About to add >>\x1b[1m$stale_cmd\x1b[0m<< to stale bookmarks."
			local proceed
			read -p "Proceed? (Y/n): " proceed
			if [ "$proceed" != n ] && [ "$proceed" != N ]
			then
				echo "$stale_cmd" >> "$SIXTEEN_DATA_DIR/stale-bookmarks"
			fi
			return
			;;
		*)
			# add stuff from current session
			history -a
			local stale_cmd=$(history | fzf --prompt='stale> ')
			;;
	esac
	# check we actually chose something
	if [[ -z "$stale_cmd" ]]
	then
		echo 'Ok, back to the present I guess...'
		return
	fi
	# history should come with dates; see ~/.bashrc
	stale_cmd=${stale_cmd#*|}
	local proceed
    local prompt=$(printf \
        "About to run >>\x1b[1m%s\x1b[0m<<. Proceed (y/N)? " \
        "$stale_cmd" \
    )
    read -p "$prompt" proceed
	if [ "$proceed" = y ] || [ "$proceed" = Y ]
	then
		eval "$stale_cmd"
		history -s "$stale_cmd"
	else
		echo "...well, I guess we're not doing that then"
	fi
}

function pathgrep {
	find $(echo $PATH | sed -e 's/:/ /g') -maxdepth 1 -type f,l 2>/dev/null |
		xargs stat --format=%N |
		grep $@
}

# Pass argument 'd' to get project directories
function project_files {
    local item_type=f
    [[ -n $1 ]] && item_type=$1
    find \
        -path '*node_modules*' \
        -o -path '*.git*' \
        -o -path '*.venv*' \
        -prune -o \
        -type $item_type -print
}

# Choose a file!
function pick {
    local program=
    local choice=
    local old_ps3="$PS3"
    PS3=$(printf '\x1b[1;33mChoose a file> \x1b[0m')
    for arg in $@
    do
        case $arg in
            -h|--help)
                cat <<- EOF
Pick a file!
Ignores anything within .git, node_modules, etc. directories.
Echoes file name to stdout by default if no PROGRAM is specified
(see below).

Usage:
    pick -h|--help
Show this message
    pick -f|--fzf [PROGRAM]
Fuzzy find a file (requires fzf). Opens file with PROGRAM.
    pick -s|--select [PROGRAM]
Use bash built-in select to pick a file to open (with PROGRAM).
    pick [PATH_FRAGMENT]
Grep through all the file paths in the current directory for one whose path 
contains PATH_FRAGMENT. Opens with \$EDITOR.
EOF
                return 0
                ;;
            -f|--fzf)
                choice="$(project_files | fzf --prompt="$PS3")"
                ;;
            -s|--select)
                select file in $(project_files)
                do
                    [ -z "$file" ] && return 1
                    choice="$file"
                    break
                done
                ;;
            *) program="$arg";;
        esac
    done
    if [ -z "${choice}${program}" ]; then
        echo -e "\e[1;33mGuess we're not doing that then...\e[0m"
        return 1
    fi
    if [ -z "$choice" ]; then
        choice="$(project_files | grep ".*${program}.*" | head -n 1)"
        $EDITOR "$choice"
    elif [ -n "$program" ]; then
        $program "$choice"
        history -s $program "$choice"
    else
        echo "$choice"
    fi
    PS3="$old_ps3"
}

function lsproc {
	for pid in $(pgrep $1)
	do
		echo $pid
		cat /proc/${pid}/cmdline
		echo ''
	done
}

function yg {
    project_files | xargs grep -nHI --color=always $@
}

function mvt {
    local search_depth=8
    local search_directory=/
    local print_dir=
    local new_dir=
    while [ "$#" -gt 0 ]
    do
        case $1 in
            -c|--cwd)
                search_directory=$(pwd)
                ;;
            -d|--depth)
                search_depth=$2
                shift
                ;;
            -h|--help)
                cat <<- EOF
Move To! v1.4 (bash)
Options:
    -h,--help
        Show this help message
    -d,--depth DEPTH
        Specify how deep within the directory tree you want to search.
        Defaults to 8.
    -s,--search_directory DIRECTORY
        Specify the directory to search within. Can be relative.
        Defaults to /.
    -c,--cwd
        Search within the current working directory. Equivalent to
          -s \$(PWD)
    -p,--print
        Instead of changing the working directory, just print the chosen
        directory
EOF
                return
                ;;
            -s|--search-directory)
                search_directory=$2
                shift
                ;;
            -p|--print) print_dir=TRUE;;
            *)
                echo "mvt: Error: invalid option $1" >&2
                return;;
        esac
        shift
    done
    new_dir="$(find ${search_directory} -maxdepth ${search_depth} -type d \
        2>/dev/null | fzf)"
    # check fzf wasn't cancelled before changing directory
    if [ -n "$new_dir" -a -z "$print_dir" ]
    then
        cd "$new_dir"
    else
        echo $new_dir
    fi
}

SIXTEEN_BOOKMARKS="
/mnt
${HOME}
${HOME}/Documents
/usr
"

function get_bookmark_dirs {
    find $SIXTEEN_BOOKMARKS -maxdepth 2 -type d -not -path '*/.*' 2>/dev/null
}

function z {
    if [[ -z $1 ]]; then
        cd
        return
    fi
    cd "$(get_bookmark_dirs | grep -i "$1.*$2" | head -n 1)"
}

function zi {
    cd "$(get_bookmark_dirs | fzf)"
}

function zz {
    [[ -z $1 ]] && return 1
    cd "$(project_files d | grep -i "$1.*$2" | head -n 1)"
}
