[ -r ~/.Xresources ] && xrdb ~/.Xresources
[ -r ~/.xmodmap ] && xmodmap ~/.xmodmap
xset r rate 230
xset m 0 0 # No mouse acceleration
xset dpms 1200 1200 1200
xset s off
numlockx
[ -r ~/.xbindkeysrc ] && xbindkeys # --display 1 # If several X sessions running
urxvtd --quiet --opendisplay --fork
#conky &
#dwmstatus &
exec fluxbox
