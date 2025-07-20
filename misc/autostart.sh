#!/usr/bin/sh

NO_OPT="don't do that"
choice=$(printf "open internet stuff\n${NO_OPT}\n" | rofi -dmenu)

if [ -n "$choice" ] && [ "$choice" != "$NO_OPT" ]; then
    $BROWSER https://web.whatsapp.com https://discordapp.com/channels/@me & disown
    $MAIL & disown
fi

$TERMINAL --hold $EDITOR "$HOME/Wiki/To-Do.md" & disown
