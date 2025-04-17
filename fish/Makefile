ifeq (${XDG_CONFIG_DIR},)
	CONF_DIR=${HOME}/.config/fish
else
	CONF_DIR=${XDG_CONFIG_DIR}/fish
endif
install:
	mkdir -p $$(dirname ${CONF_DIR})
	ln -s ${PWD} ${CONF_DIR}
uninstall:
	trash ${CONF_DIR}
