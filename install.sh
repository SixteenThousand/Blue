# Please do not run this script directly; use the "install" and "uninstall"
# recipes in the Makefile

operation=$1
toplevel=$PWD

for app in $(find . -mindepth 1 -maxdepth 1 -type d -not -name '.git*'); do
  cd "$app"
  if make "$operation"; then
    printf "\e[1;33m[${app}] configured!\e[0m\n"
  else
    printf "\e[1;31m[${app}] configuration failed!\e[0m\n"
  fi
  cd "$toplevel"
done
