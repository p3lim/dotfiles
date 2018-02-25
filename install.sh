#!/usr/bin/bash

user=$(whoami)

cd "$(dirname "${BASH_SOURCE[0]}")"

link(){
	local target=$1
	local path=$2

	[[ -z "$path" ]] && path="/home/$user/$target"

	# make sure the parent directory exists
	local parent="$(dirname "$path")"
	if ! [[ -d "$parent" ]]; then
		mkdir -p "$parent"
	fi

	ln -sb "$(pwd)/$target" "$path"
}

# symlinks
link '.bash_profile'
link '.bashrc'
link '.inputrc'
link '.xinitrc'
link '.xprofile'
link '.xresources'

link 'bin'
link '.config/bash'
link '.config/bspwm'
link '.config/compton'
link '.config/eventd'
link '.config/git'
link '.config/i3'
link '.config/micro'
link '.config/rofi'
link '.config/termite'
link '.config/gtk-3.0/gtk.css'
link '.config/sublime-text-3/Packages/C++'
link '.config/sxhkd'

for file in .config/sublime-text-3/Packages/User/*; do
	link ".config/sublime-text-3/Packages/User/$(basename $file)"
done

for file in .config/sublime-text-3/Packages/Default/*; do
	link ".config/sublime-text-3/Packages/Default/$(basename $file)"
done

for file in .config/systemd/user/*; do
	link ".config/systemd/user/$(basename $file)"
done

link '.mozilla/firefox/profiles.ini'
link '.mozilla/firefox/custom/chrome'

# copy config files
sudo cp --parents -rb etc /
sudo cp --parents -rb usr /
sudo cp --parents -rb root /

# use "unpredictable" network interface names
sudo ln -s /dev/null /etc/systemd/network/99-default.link

# enable wpa_supplicant on wifi interface
sudo systemctl enable wpa_supplicant@wlan0.service

# enable cronie
sudo systemctl enable cronie.service --now

# enable eventd-watcher
systemctl --user enable eventd-watcher.service --now

# enable sxhkd
systemctl --user enable sxhkd.service --now

# speed up compilation by building in tmpfs
sudo sed -i '/BUILDDIR/s/^#//g' /etc/makepkg.conf

if [[ -f private/install.sh ]]; then
	bash private/install.sh
fi
