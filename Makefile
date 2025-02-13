install:
	./blue install \
		alacritty \
		awesomewm \
		bash \
		dunst \
		kitty \
		misc \
		nnn \
		nvim \
		rofi \
		swaywm
uninstall:
	./blue uninstall $$(command ls --color=never)
