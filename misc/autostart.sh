#!/usr/bin/sh

DEFAULT_OPT="open internet stuff"
NO_OPT="don't do that"
MAKERS_OPT=makers
choice=$(printf "${DEFAULT_OPT}\n${NO_OPT}\n${MAKERS_OPT}" | fuzzel -dmenu)

[ -z "$choice" ] && exit 0

case $choice in
    $NO_OPT)
        exit 1
        ;;
    $MAKERS_OPT)
        $BROWSER \
            'journey.makers.tech' \
            'https://calendar.google.com/calendar/u/0/r/week' \
            'https://web.whatsapp.com' \
            'https://app.slack.com/client/T03ALA7H4/D09GF9J7E5Q' \
            'https://www.zoom.com/?lang=en-US' \
            'https://makers-tech.zoom.us/j/88263200586?pwd=SW1rVjJVcTkrNjFZVmt5cGtjVmR6dz09' \
            & disown
        notify-send -a 'autostart' 'Makers' 'Remember to jibble in!'
        ;;
    $DEFAULT_OPT|*)
        $BROWSER \
            'https://calendar.google.com/calendar/u/0/r/week' \
            'https://web.whatsapp.com' \
            'https://discordapp.com/channels/@me' \
            'https://mail.google.com/mail/u/0/#inbox' \
            'https://mail.google.com/mail/u/1/#inbox' \
            & disown
        $MAIL & disown
        ;;
esac
