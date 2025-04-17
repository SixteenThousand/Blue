install:
	./blue install \
		alacritty \
		bash \
		dunst \
		herbstluftwm \
		kitty \
		misc \
		nvim \
		rofi \
		swaywm
uninstall:
	find -mindepth 1 -maxdepth 1 -type d -not -name '.git*' | \
		xargs ./blue uninstall
