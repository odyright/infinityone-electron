#!/bin/bash

# This script runs when user uninstall the debian package.
# It will remove all the config files and anything which was added by the app.

# Remove apt repository source list when user uninstalls InfinityOne app
if grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep infinityone.list; then
	sudo apt-key del 69AD12704E71A4803DCA3A682424BE5AE9BD10D9;
	sudo rm /etc/apt/sources.list.d/infinityone.list;
fi

# Get the root user
if [ $SUDO_USER ];
	then getSudoUser=$SUDO_USER;
	else getSudoUser=`whoami`;
fi

# Get the path for Zulip's desktop entry which is created by auto-launch script
getDesktopEntry=/home/$getSudoUser/.config/autostart/infinityone.desktop;

# Remove desktop entry if exists
if [ -f $getDesktopEntry ]; then
    sudo rm $getDesktopEntry;
fi

# App directory which contains all the config, setting files
appDirectory=/home/$getSudoUser/.config/InfinityOne/;

if [ -d $appDirectory ]; then
    sudo rm -rf $appDirectory;
fi

# Delete the link to the binary
echo 'Removing binary link'
sudo rm -f '/usr/local/bin/${executable}';
