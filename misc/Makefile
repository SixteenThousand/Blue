IGNORE=--ignore=Makefile --ignore=autostart.sh
AUTOSTART_DIR=${HOME}/.config/autostart
install:
	mkdir -p ${AUTOSTART_DIR}
	cp -f ./autostart.sh ${AUTOSTART_DIR}
	cd ${HOME} && mkdir -p \
		.local/bin \
		.local/share/applications \
		.local/share/icons
	stow -S . -t ${HOME} ${IGNORE}
uninstall:
	stow -D . -t ${HOME} ${IGNORE}
	rm ${AUTOSTART_DIR}/autostart.sh
build:
	cp -f ./autostart.sh ${AUTOSTART_DIR}
