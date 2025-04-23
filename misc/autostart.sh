#!/bin/sh

$BROWSER https://web.whatsapp.com & disown
$MAIL & disown
$TERMINAL --hold $EDITOR "$HOME/Wiki/To-Do.md"
