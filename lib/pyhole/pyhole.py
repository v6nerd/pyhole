#!/usr/bin/env python3

# pyhole - a clone of the Pi-hole DNS adblocker, written in Python.
# pyhole  (c) 2016 by ryt51V
# Pi-Hole (c) 2015, 2016 by Jacob Salmela

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3 of the License.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# For running system commands
import os
# For validating user provided IPs.
import ipaddress
# For managing our conf file
import configparser

########################
###     Variables    ###
########################

# These should already exist if installed by the .deb package.
config_dir = '/etc/pyhole'
share_dir  = '/usr/share/pyhole'
var_dir    = '/var/lib/pyhole'

conf_file_path = os.path.join(config_dir, 'pyhole.conf')

########################
##  Helper Functions  ##
########################

def valid_ip(ip):
    """Return True if an IP is valid, false otherwise."""
    try:
        ipaddress.ip_address(ip)
        return True
    except:
        return False
    #end except
#end def valid_ip(ip):

def valid_port(port):
    """Return True if a port is valid, false otherwise."""
    try:
        port_int = int(port)
        return port_int in range(1,65536)
    except:
        return False
    #end except:
#end def valid_port(port):

########################
###     Conf file    ###
########################

config = configparser.ConfigParser()

# Read the config.  This doesn't seem to error if the file doesn't exist.
config.read(conf_file_path)

def write_config():
    global config
    global conf_file_path
    
    with open(conf_file_path, 'w') as conf_file:
        config.write(conf_file)
    #end with
    
#end def write_config:

