#!/usr/bin/env python

import sys

from utils import get_focusfile, get_file_lines
from base import HostsFile

hostsfile = HostsFile("/etc/hosts", backup="/tmp/hosts.bak")
ENABLE_WWW = True

def error():
    print "Please specify either 'activate' or 'deactivate'"
    sys.exit(1)

def host_action(action):

    fname = {
        "activate": "add_host",
        "deactivate": "remove_host"}.get(action)

    if not fname:
        error()

    action_func = lambda host: getattr(hostsfile, fname)(host, "127.0.0.1")

    for host in get_file_lines(get_focusfile()):
        action_func(host)

        if ENABLE_WWW and not host.startswith("www."):
            action_func("www."+host)

    hostsfile.write()

def activate():
    host_action("activate")
    print "Focus is activated... go!"


def deactivate():
    host_action("deactivate")
    print "Focus is deactivated..."

if __name__ == "__main__":

    if len(sys.argv) != 2 or sys.argv[1] not in ["activate", "deactivate"]:
        error()

    sys.argv[1]()
