for arg in $@
do
	if [ "$arg" = '-h' -o "$arg" = '--help' ]
	then
		cat <<- EOF
		This script should be run as:
		    bash ./scripts/new-app.sh APPNAME REPO_VISIBILITY
		from the project top-level, i.e. Blue.
		
		APPNAME is the name of the application you want to add a 
		configuration for, e.g. riverwm. The new config repo will be in a 
		directory called ./configs/APPNAME, and its corresponding GitHub
		repo will be called blue-APPNAME.
		
		REPO_VISIBILITY should be one of 'public' and 'private'. It controls 
		the visibility of the GitHub repo. Defaults to 'private'.
		EOF
		exit 0
	fi
done

if [ ! "$(basename $(pwd))" = 'Blue' ]
then
	echo -e "\e[1;31mYou can only run this script from the project \
toplevel, i.e. Blue!\e[0m"
	exit 1
fi

name=$1
visibility='--'${2:-'private'}

DESCRIPTION='Please see https://github.com/SixteenThousand/Blue for more information about this repository'


cd ./configs

gh repo create "blue-$name" --description "$DESCRIPTION" $visibility --clone

mv "blue-$name" $name

cd ..
git submodule add "https://github.com/SixteenThousand/blue-$name" "./configs/$name"
