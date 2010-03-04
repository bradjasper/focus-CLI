#!/usr/bin/env python

import sys

from utils import get_focusfile, get_file_lines
from base import HostsFile

hostsfile = HostsFile("/etc/hosts", backup="/tmp/hosts.bak")

def activate():
    for host in get_file_lines(get_focusfile()):
        hostsfile.add_host(host, "127.0.0.1")
    hostsfile.write()
    print "Focus is activated. Go work!"

def deactivate():
    for host in get_file_lines(get_focusfile()):
        hostsfile.remove_host(host)
    hostsfile.write()
    print "Focus is deactivated, how'd it go?"


if __name__ == "__main__":

    def error():
        print "Please specify either 'activate' or 'deactivate'"
        sys.exit(1)

    if len(sys.argv) != 2:
        error()

    if sys.argv[1] == "deactivate":
        deactivate()
    elif sys.argv[1] == "activate":
        activate()
    else:
        error()
