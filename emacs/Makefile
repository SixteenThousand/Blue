CONF_DIR=$(HOME)/.emacs.d

install:
	mkdir -p $(CONF_DIR)
	stow -S . -t $(CONF_DIR)

uninstall:
	stow -D . -t ${CONF_DIR}
