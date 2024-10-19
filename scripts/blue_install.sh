declare -a apps

apps=(
	# alacritty
	# awesomewm
	bash
	clifm
	fish
	i3wm
	misc
	neovide
	nvim
	riverwm
	rofi
	swaywm
	wayfire
	wezterm
)

for app in ${apps[@]}
do
	app_dir="configs/$app"
	if [ -d "$app_dir" ]
	then
		cd ./configs/$app
		if make $1
		then
			echo -e "\e[1m[$app] configured!\e[0m"
		fi
		cd ../..
	else
		echo "[configs/$app] does not exist!"
	fi
done
