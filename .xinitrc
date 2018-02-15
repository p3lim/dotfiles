if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

[[ -f ~/.xresources ]] && xrdb -merge ~/.xresources
[[ -f ~/.xprofile ]] && . ~/.xprofile

dbus-launch --sh-syntax --exit-with-session i3
