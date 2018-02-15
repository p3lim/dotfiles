user=$(whoami)

[[ -n "$SUDO_USER" ]] && user=$SUDO_USER

if [[ -d /home/$user/.config/bash/ ]]; then
	for file in /home/$user/.config/bash/*; do
		source "$file"
	done
fi

if [[ -d /home/$user/.config/bash_private/ && -z "$SUDO_USER" ]]; then
	for file in /home/$user/.config/bash_private/*; do
		source "$file"
	done
fi

unset user
