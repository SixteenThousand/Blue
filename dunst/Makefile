install:
	ln -s $(PWD) $(HOME)/.config/dunst
uninstall:
	rm -I $(HOME)/.config/dunst
build:
	killall dunst
	dunst & disown
run:
	notify-send "Some dumb app" "Hello, World!"
