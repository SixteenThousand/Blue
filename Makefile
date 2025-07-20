APPS=`find -mindepth 1 -maxdepth 1 -type d -not -name '.git*'`
install:
	git config set --local core.hooksPath .githooks
	type stow || echo 'Please install stow!'
	sh install.sh install

uninstall:
	sh install.sh uninstall
