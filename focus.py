#!/usr/bin/env python

# Focus is a script that will block websites

import os
import logging
import re

hostsfile = "/etc/hosts"
hostsfilebak = "/tmp/hosts.bak"
dotfile = os.path.expanduser("~/.focus")

def get_file_lines(filename):
    "Return all lines from a file"

    with open(filename) as file:
        return (line.strip() for line in file.readlines())

def split_hosts_line(line):
    "Split a /etc/hosts line into manageable parts"

    if line.startswith("#"):
        return line

    return re.split("\s+", line)

def combine_hosts_line(line):
    "Combine an /etc/hosts line back into the proper format"

    if isinstance(line, basestring) and line.startswith("#"):
        return line

    return "\t".join(line)

def host_exists(host, lines):
    "Check if a host exists within an array of /etc/hosts lines"

    for line in lines:
        
        if isinstance(line, list):
            if line[1] == host:
                return True
    return False


def add_new_hosts(lines, hosts):
    "Add new hosts to a list if they don't already exist"

    for host in hosts:
        if host_exists(host, lines):
            logging.warning("'%s' already exists in %s, skipping", host, hostsfile)
        else:
            lines.append(["127.0.0.1", host])
    return lines


def write_new_hosts(hosts):
    "Write out the hosts to the /etc/hosts file"

    print hostsfile, hostsfilebak
    os.rename(hostsfile, hostsfilebak)

    with open(hostsfile, "w") as file:
        for host in hosts:
            file.write(combine_hosts_line(host) + "\n")


focus_urls = get_file_lines(dotfile)

old_lines = [split_hosts_line(line) for line in get_file_lines(hostsfile)]
new_lines = add_new_hosts(old_lines, focus_urls)

write_new_hosts(new_lines)

print "Done!"
