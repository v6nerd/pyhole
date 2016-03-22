# Not yet...

It's not ready yet.  Don't bother downloading, you'll be very disappointed ;-)

# Features

- Pi-hole rewritten in Python from the ground up.
- Tested on Raspbian and Debian.  Should work on any Debian-based distro.
- Builds into a .deb package, which can be (relatively) easily and cleanly installed and removed with dpkg.
- Support for systems with multiple IPv4 addresses on an interface (which is strongly recommended if running another web server on the same server).
- Support for configuring multiple web servers - currently lighttpd and apache.
- Support for installing to any web server that you have / will manually configure yourself.
- Support for upstream DNS servers running on custom ports - useful for restricted firewalls and running forwarders on the same server.
- Admin web interface now runs on a separate port.
- Password protect the admin web interface at the web server level.
- All in one Git repo - admin web interface is now a subtree instead of separate.
- Better adherence to general Linux file location and permission best practices.

# Known issues

Issues in **bold** are work in progress.

## In common with the original Pi-hole

- Heavily tied into Debian; won't work on a distro without apt.
- Uses sudo, againt best practices.
- No package in apt repository.
- Can't configure a static IP on Debian.  (Can on Raspbian which uses dhcpcd for static IP configuration).
- **Can't be used together with an existing lighttpd server.**
- **No nginx support.**

## Regressions from Pi-hole

- **No one-line installer (`curl -L install.pi-hole.net | bash`).  Dependencies need to be installed manually with apt.**
- The admin interface password is stored as an MD5 hash, as lighttpd's mod_auth requires htpasswd files use MD5.
- Some options missing, such as --quiet switches.
- No spinner `-\|/-`
- **Very little space-related output.**
- Unoriginal and uninspired name.

# Misc changes

Blacklisting and whitelisting are greatly simplified.
- Blacklisted domains are now written to a separate hosts file, not the main gravity hosts file.  dnsmasq uses both gravity.hosts and blacklist.hosts.
- Whitelisted domains are searched for in the main gravity hosts file, and if present then **commented**.  Removing a domain from the whitelist uncomments the line.  This also fixes an issue where un-whitelisting a domain adds a blocking entry into the hosts file where one may have not existed.
