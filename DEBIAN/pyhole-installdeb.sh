#!/bin/bash

thisdir=$(dirname "$0")

# Create the deb
source "$thisdir/pyhole-builddeb.sh"

# Install dependencies
sudo apt-get install sudo dnsmasq python3 python3-dialog python3-netifaces python3-apt apache2-utils php5-common php5-cgi php5

# Install the deb
sudo dpkg -i "$thisdir/pyhole.deb"

# Fix any missing dependencies
sudo apt-get -f install

