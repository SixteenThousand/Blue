CONFIG_DIR=${HOME}/.config/niri

install:
	mv ${CONFIG_DIR} ./OLD-niri-config || :
	ln -sf ${PWD} ${CONFIG_DIR}

uninstall:
	rm -I ${CONFIG_DIR}

build: panel/*
	killall waybar
	waybar -c ./panel/waybar.jsonc -s panel/waybar.css & disown
