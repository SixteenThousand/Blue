ifeq (${XDG_CONFIG_DIR},)
	CONF_DIR=${HOME}/.config/river
else
	CONF_DIR=${XDG_CONFIG_DIR}/river
endif
install:
	mkdir -p $$(dirname ${CONF_DIR})
	ln -s ${PWD} ${CONF_DIR}
uninstall:
	rm -I ${CONF_DIR}
