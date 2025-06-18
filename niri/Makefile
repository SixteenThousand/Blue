install:
	ln -sf ${PWD} ${HOME}/.config/niri

uninstall:
	rm -I ${HOME}/.config/niri

build: panel/*
	killall waybar
	waybar -c ./panel/waybar.jsonc -s panel/waybar.css & disown
