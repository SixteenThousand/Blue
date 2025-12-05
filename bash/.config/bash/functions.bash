# scripts that either can't be separate files or are just too small to be

function book {
  local old_dir=$PWD
  cd ${1:-~/Documents/Books-and-Things}
  local book=$(fzf)
  if [[ -n "$book" ]]; then
    xdg-open "file://${PWD}/${book}" & disown
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
        -o -path '*venv*' \
        -prune -o \
        -type $item_type -print \
        2>/dev/null
}

# Choose a file!
function pick {
  local choice=
  local old_ps3="$PS3"
  PS3=$(printf '\x1b[1;33mChoose a file> \x1b[0m')
  case $1 in
    -h|--help)
      cat <<- EOF
Pick a file!
Ignores anything within .git, node_modules, etc. directories.
Opens with \$EDITOR

Usage:
    pick -h|--help
Show this message
    pick
Pick file with fzf, or select if fzf is not available
    pick [PATH_FRAGMENT]
Grep through all the file paths in the current directory for one whose path 
contains PATH_FRAGMENT. Opens with \$EDITOR.
EOF
      return 0
      ;;
    *)
      choice="$(project_files | grep ".*$1.*" | head -n 1)"
      ;;
  esac
  if type fzf >/dev/null 2>&1; then
    choice="$(project_files | fzf --prompt="$PS3")"
  else
    select file in $(project_files); do
      choice="$file"
      break
    done
  fi
  if [ -z "$choice" ]; then
      printf "\e[1;33mGuess we're not doing that then...\e[0m\n"
      return 1
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

SIXTEEN_BOOKMARKS="
/mnt
${HOME}
${HOME}/Documents
/usr
"

function get_bookmark_dirs {
    find $SIXTEEN_BOOKMARKS -maxdepth 3 -type d -not -path '*/.*' 2>/dev/null
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
