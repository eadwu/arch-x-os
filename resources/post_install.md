# Post Installation
Setup your wifi with [netctl](https://github.com/Kutoru/arch-x-os/blob/master/resources/netctl.md) and run `ping -c 3 google.com` to verify that you have a connection.

## Sources
LearnLinux.tv's [Installing Arch Linux (Post Install)](https://www.youtube.com/watch?v=GCUmGtCYPWM)

LearnLinux.tv's [Getting Started with Arch Linux (Second Edition) Part 6: Setting up NTP and Bluetooth](https://www.youtube.com/watch?v=TNDisr6z7Rc)

Tech Linux's [Ep4: How to setup network manager, usb, and more](https://www.youtube.com/watch?v=DtohxreWjVg)

wiki.archlinux.org [PulseAudio/Troubleshooting](https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting)

wiki.archlinux.org [Bluetooth_headset](https://wiki.archlinux.org/index.php/Bluetooth_headset)

#### Audio
Run `pacman -Sy pulseaudio alsa-utils` and then `alsamixer`. Unmute by pressing M and bring the scales up until the dB gain is 0.00. "The MM label below a channel indicates that the channel is muted, and 00 indicates that it is open." -- [wiki.archlinux.org](https://wiki.archlinux.org/index.php/PulseAudio/Troubleshooting)

#### Editing /etc/pacman.conf
Run `nano /etc/pacman.conf`
Uncomment

    [multilib]
    Include=/etc/pacman.d/mirrorlist

for 32-bit package installation.
Add the following for AUR package support

    [archlinuxfr]
    SigLevel = Never
    Server = http://repo.archlinux.fr/$arch

Run `pacman -Sy yaourt` to install yaourt. Verify yaourt is installed by `which yaourt`.

#### Wireless Connection
Run `pacman -Sy networkmanager network-manager-applet wireless_tools wpa_supplicant gnome-keyring`

#### XOrg and Trackpad Driver
Run `pacman -Sy xf86-input-libinput xorg-server xorg-xinit xorg-server-utils mesa`

#### Graphic Drivers
This is assuming that you have Intel Graphics.
If not look [here](https://wiki.archlinux.org/index.php/xorg#Driver_installation) or for a spreadsheet made by other Linux users look [here](https://docs.google.com/spreadsheets/d/1nG9Y9nhA615IkjNUE_ew7JmiVHD7ORA4BExW0-teQ40/edit#gid=897452601).
**Remember that the distro is Arch Linux.**

Run `pacman -Sy mesa-libgl` to install the drivers for Intel cards. I use the modesetting driver.

If you want the 32-bit drivers as well then run `pacman -Sy lib32-intel-dri lib32-mesa lib32-libgl`

#### NTP (Network Time Protocol)
Basically checks your time with internet time servers to verify it's accurate. See [here](https://wiki.archlinux.org/index.php/Network_Time_Protocol_daemon) for more information.

Run `pacman -Sy ntp` to install NTP.

Run `systemctl daemon-reload` and then `systemctl enable ntpd`.

#### Bluetooth

Run `pacman -Sy bluez bluez-utils blueman pulseaudio-bluetooth`.

Then run `systemctl daemon-reload` and then `systemctl enable bluetooth`.

**Headset connected but no sound**
Find your headset from running `pacmd ls` and then get the index value of your headset and run `pacmd set-card-profile INDEX_HERE a2dp_sink`.

**Headset Output Autoswitch**
Edit /etc/pulse/default.pa by running `nano /etc/pulse/default.pa` and add the following snippet to it.

    ### automatically switch to newly-connected devices
    load-module module-switch-on-connect

#### Trackpad Configuration
The default Apple trackpad movements is clickfinger based (see [here](https://wayland.freedesktop.org/libinput/doc/latest/clickpad_softbuttons.html#clickfinger)). This changes it to a button area based format (see [here](https://wayland.freedesktop.org/libinput/doc/latest/clickpad_softbuttons.html#software_buttons)). This also changes the Middle Mouse to be clicking the left and right buttons at the same time inside of the center of the trackpad.

Generate `30-touchpad.conf` by running `nano /etc/X11/xorg.conf.d/30-touchpad.conf` and put the following snippet inside it.

    Section "InputClass"
      Identifier "touchpad"
      Driver "libinput"
      MatchIsTouchpad "on"
      Option "ClickMethod" "buttonareas"
      Option "DisableWhileTyping" "off"
      Option "MiddleEmulation" "on"
    EndSection

#### Packages
Pacman Stuff: `pacman -Sy conky git openssh nodejs npm php redshift python-gobject python-xdg librsvg blender chromium screenfetch compton vlc ark p7zip zip unzip unrar dkms nitrogen rofi lsb-release noto-fonts-cjk ttf-liberation`

Disable XFCE's default compositor and enable compton.

Edit `~/.bashrc` and add `screenfetch` to it.

#### USB Mounting support
Run `pacman -Sy thunar-volman gvfs`.

#### Graphical Enviornment
###### LightDM
Run `pacman -Sy lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings`. Then enable it by running `systemctl enable lightdm.service`
###### XFCE
To install XFCE run `pacman -Sy xfce4 xfce4-goodies`.
###### i3
Run yaourt in your user `su $USER`

To install i3 run `yaourt i3-gaps`.

#### Enabling NetworkManager
Run `yaourt -S xfce4-indicator-plugin` then `systemctl disable netctl.service` to disable netctl and then to enable NetworkManager run `systemctl enable NetworkManager.service`.

#### Misc/Other Applications
oblogout-blurlock: `yaourt oblogout-blurlock` (i3lock blurlock function)

Atom Beta: `yaourt atom-editor-beta-bin`

Broadcom-wl-dkms: `yaourt broadcom-wl-dkms`

Flow: `yaourt flow javascript` (flow-bin)

Discord: `yaourt discord`

Pamac: `yaourt pamac-aur`

Paper Icons: `yaourt paper-icon-theme-git`

Adapta: `yaourt adapta-gtk-theme` (for notifications)

Arc Dark: `yaourt gtk-theme-arc-git` (normal theme)

#### Atom Configuration
Go into the atom packages folder `cd ~/.atom/packages`.

Building from source:

1) Uninstall the package currently installed

2) Clone repo by `git clone HTTP_REPO_GIT`

3) Cd to the folder `cd FOLDER_NAME`

4) Install dependencies `npm i`

Build `Browser Plus` from source.

For Linter v2 refer [here](https://github.com/steelbrain/linter-ui-default#installation).