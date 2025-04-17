#!/bin/bash

declare -a themes
themes=(
	'1984 Dark'
	'ANSI 1987'
	'Campbell'
	'Carbonfox'
	'Catppuccin-Frappe'
	'Dawnfox'
	'Desert'
	'Everforest Dark Hard'
	'Everforest Light Hard'
	'GitHub Light High Contrast'
	'Gruvbox Dark'
	'Gruvbox Dark Hard'
	'Gruvbox Light'
	'Gruvbox Light Hard'
	'Gruvbox Material Light Medium'
	'Neowave'
	'Nightfox'
	'purpurite'
	'Rosé Pine Moon'
	'Terafox'
)

num_themes=$((${#themes[@]} - 1))
for i in $(seq 0 $num_themes)
do
	theme_file="./themes/$(echo "${themes[$i]}" | sed -e 's/ /-/g').conf"
	kitten theme --cache-age=-1 --dump-theme "${themes[$i]}" > "$theme_file"
done
