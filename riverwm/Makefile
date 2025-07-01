CONF_DIR=${HOME}/.config/river

install:
	mv ${CONF_DIR} ./OLD-river-config || :
	mkdir -p $$(dirname ${CONF_DIR})
	ln -s ${PWD} ${CONF_DIR}

uninstall:
	rm -I ${CONF_DIR}
