declare -A FLAGS
FLAGS[depth]=8
FLAGS[search_directory]=/

while [ "$#" -gt 0 ]
do
	case $1 in
		-c|--cwd)
			FLAGS[search_directory]=$(pwd);;
		-d|--depth)
			FLAGS[depth]=$2
			shift;;
		-h|--help)
			cat <<- EOF
			Move To! v1.4 (bash)
			Options:
			    -h,--help
			        Show this help message
			    -d,--depth DEPTH
			        Specify how deep within the directory tree you want to search.
			    -s,--search_directory DIRECTORY
			        Specify the directory to search within. Can be relative.
			    -c,--cwd
			        Search within the current working directory. Equivalent to
			          -s \$(PWD)
			    -p,--print
			        Instead of changing the working directory, just print the chosen
			        directory
			EOF
			return;;
		-s|--search-directory)
			FLAGS[search_directory]=$2
			shift;;
		-p|--print) FLAGS[print]=TRUE;;
		*)
			echo "mvt: Error: invalid option $1" >&2
			return;;
	esac
	shift
done

NEW_DIR="$(find ${FLAGS[search_directory]} -maxdepth ${FLAGS[depth]} -type d \
	2>/dev/null | fzf)"
# check fzf wasn't cancelled before changing directory
if [ -n "$NEW_DIR" -a -z "${FLAGS['print']}" ]
then
	cd "$NEW_DIR"
else
	echo $NEW_DIR
fi


unset FLAGS NEW_DIR
