#!/usr/bin/env sh

XDG_MENU_PREFIX=sxtt- kbuildsycoca6 --noincremental

systemctl --user start dunst
systemctl --user start sxtt-blueman-applet
# systemctl --user start sxtt-kwallet-pam

/usr/share/libpam-kwallet-common/pam_kwallet_init
