#!/usr/bin/env python

import sys

from utils import get_focus_urls
from base import HostsFile

hostsfile = HostsFile("/etc/hosts", backup="/tmp/hosts.bak")
ENABLE_WWW = True
LOCALHOST = "127.0.0.1"

def error():
    print "Please specify either 'activate' or 'deactivate'"
    sys.exit(1)

def host_action(fname):

    action_func = lambda host: getattr(hostsfile, fname)(host, LOCALHOST)

    for host in get_focus_urls():

        action_func(host)

        if ENABLE_WWW and not host.startswith("www."):
            action_func("www."+host)

    hostsfile.write()

def activate():
    host_action("add_host")
    print "-> Focus is activated... Go focus!"


def deactivate():
    host_action("remove_host")
    print "-> Focus is deactivated... Were you productive?"

if __name__ == "__main__":

    if len(sys.argv) != 2 or sys.argv[1] not in ["activate", "deactivate"]:
        error()

    sys.argv[1]()
