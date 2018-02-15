# load .bashrc from the sudo-ing user
if [[ -n "$SUDO_USER" ]]; then
	if [[ -f /home/$SUDO_USER/.bashrc ]]; then
		source /home/$SUDO_USER/.bashrc
	fi
fi

