#!/bash/sh

# setxkbmap -layout gb -variant mac
# setxkbmap -layout us -option compose:caps
setxkbmap -layout us -option compose:ralt -variant mac

# setxkbmap -layout us -option compose:ralt
# picom & 

xsetroot -solid '#1e1e2e'

sxhkd &

exec bspwm
