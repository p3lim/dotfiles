if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

[[ -f ~/.xresources ]] && xrdb -merge ~/.xresources
[[ -f ~/.xprofile ]] && . ~/.xprofile

exec i3
#exec bspwm
