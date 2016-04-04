[Pi-Hole](https://github.com/pi-hole/pi-hole) is a DNS ad-blocker.  It's awesome, but it didn't quite fit my needs, so I wrote my own clone - pyhole.

This is my own clone for my own personal use, but I thought I'd upload it to GitHub in case it's of use to anyone else.  It is not a stable project and currently has no focus on backwards compatibility (the original Pi-hole is far better in these respects).  If you're a developer, please excuse the Python code littered with PowerShell conventions ;-)

# Features

- Pi-hole rewritten in Python from the ground up.
- Tested on Raspbian and Debian.  Should work on any Debian-based distro, e.g. Ubuntu.
- Tested with Python 3.4.  Should work with Python 3.4 and newer.
- Builds into a .deb package, which can be more easily and cleanly installed, upgraded, and removed with dpkg.
- Support for systems with multiple IPv4 addresses on an interface (which is strongly recommended if running another web server on the same server).
- Support for configuring multiple web servers - currently lighttpd and apache.  Using another web server?  So long as you manually configure it correctly, pyhole can work with that too.
- Support for upstream DNS servers running on custom ports - useful for restricted firewalls and running forwarders on the same server.
- Password protect the admin web interface at the web server level.
- Better adherence to general Linux file location and permission best practices.

# Installation

## Manual install from GitHub

1. Ensure sudo is installed by running the following as root:
    - `apt-get install sudo`
2. Install a web server of your choise - lighttpd or apache.  If unsure install lighttpd.  (Advanced users can use any web server.)
    - `sudo apt-get install lighttpd` , OR
    - `sudo apt-get install apache2 libapache2-mod-php5`
3.  Clone this Git repository.
    - `git clone "https://github.com/pyhole/pyhole.git"`
4.  Run pyhole-installdeb.sh which will build the deb, install dependencies, and install the deb with dpkg.
    - `sudo ./pyhole/DEBIAN/pyhole-installdeb.sh`
5.  Run pyhole-config, which will guide you through configuring pyhole.
    - `sudo pyhole-config`

# Known issues and limitations

Issues in **bold** may be fixed eventually.

## In common with the original Pi-hole

- **No nginx support.**
- Heavily tied into Debian; won't work on a distro without apt.
- Uses sudo againt best practices.  Used to run certain scripts as pyhole user.
- No package in apt repository.
- No HTTPS support.

## Regressions from Pi-hole

- **No one-line installer at present.**
- **Uninstalling with dpkg does not yet perform a 100% removal.**
- The downside of pyhole being significantly more configurable is that there are many more settings when running pyhole-config, which may be daunting to newbies.  Steps to mitigate this include most dialogs have an "If you are unsure, do X." to guide newbies.
- Unlike whiptail, dialog does not draw correctly with PuTTY when using UTF-8 in its default form.  Not exactly a pyhole issue; see <http://www.novell.com/support/kb/doc.php?id=7015165> for solutions.
- The admin interface password is stored as an MD5 hash, as lighttpd's mod_auth requires htpasswd files use MD5.
- Some options missing, such as --quiet switches.
- No spinner `-\|/-`
- Very little space-related output.
- Unoriginal and uninspired name.

# Developer notes

- The install process is now split into (building/)installing the deb package, and running pyhole-config to interactively configure.
- There does not seem to be a good declarative way to set an IP address in Linux, and distros differ heavily in this regard (even Raspbian vs Debian).  Rather than risk ruining a system, users are ONLY offered to have a static IP configured for them if they are running Raspbian.  Those on other distros / platforms are more likely to be advanced users who can configure a static IP or figure out how.
- Significant code is offloaded into the pyhole Python module and imported into each script, making code reuse far easier.
- gravity.list is now named gravity.hosts to distinguish from downloaded lists.
- Blacklisting and whitelisting have been overhauled and are greatly simplified.
	- Blacklisted domains are now written to a separate hosts file - blacklists.hosts.  dnsmasq uses both gravity.hosts and blacklist.hosts.
	- Whitelisted domains are searched for in the main gravity hosts file, and if present then **commented**.  Removing a domain from the whitelist uncomments the line.  This also fixes an issue where un-whitelisting a domain adds a blocking entry into the hosts file where one may have not existed.
- Admin web interface now runs on a separate port (8080).
- The AdminLTE is now a git subtree (**not** a submodule) in the same repo.  Subtrees still let us pull from upstream, but allow the sole repo to be a point-in-time snapshot.
