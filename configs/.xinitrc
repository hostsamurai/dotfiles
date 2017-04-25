#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[ -f ~/.xprofile ] && . ~/.xprofile

# DE/WM selection
echo $@
echo $1
session=${1:-gnome}
echo $session

case $session in
  awesome ) exec awesome;;
  stumpwm ) exec sbcl --eval "(ql:quickload \"stumpwm\" )" --eval "(stumpwm:stumpwm)";;
  gnome   ) exec gnome-session;;
  budgie  ) export XDG_CURRENT_DESKTOP=Budgie:GNOME && exec budgie-desktop;;
  i3      ) exec i3;;
  bspwm   ) exec bspwm;;
  # no known session, so run the default
  *) exec $1;;
esac
