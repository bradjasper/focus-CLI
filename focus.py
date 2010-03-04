#!/usr/bin/env python

from utils import get_focusfile, get_file_lines
from base import HostsFile
# Focus is a script that will block websites

hostsfile = HostsFile("/etc/hosts")

for host in get_file_lines(get_focusfile()):
    print host
    hostsfile.add_host(host, "127.0.0.1")

hostsfile.write("/etc/hosts", backup="/tmp/hosts.bak")

"""


focus_urls = get_file_lines(dotfile)

old_lines = [split_hosts_line(line) for line in get_file_lines(hostsfile)]
new_lines = add_new_hosts(old_lines, focus_urls)

write_new_hosts(new_lines)

print "Done!"
"""
