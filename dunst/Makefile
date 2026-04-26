install:
	ln -s $(PWD) $(HOME)/.config/dunst

uninstall:
	rm -I $(HOME)/.config/dunst

build:
	killall dunst || :
	nohup dunst > ${HOME}/.nohup.out 2>&1 &

run:
	notify-send "Some dumb app" "Hello, World!"
