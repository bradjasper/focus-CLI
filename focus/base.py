import re
import logging
from shutil import copyfile

from utils import get_file_lines

class HostsFile(object):
    """Represents an /etc/hosts file"""

    def __init__(self, path="/etc/hosts", backup="/tmp/hosts.bak"):
        self.path = path
        self.backup = backup
        self.lines = self.parse_hosts_file(self.path)

    def write(self):
        "Write out the hosts file to a path"

        if self.backup:
            copyfile(self.path, self.backup)

        with open(self.path, "w") as file:
            for line in self.lines:
                file.write(unicode(line))

    def host_exists(self, host):
        "Check if a host exists within an array of /etc/hosts lines"

        for line in self.lines:
            if line.is_host and line.host == host:
                return True

        return False

    def add_host(self, host, ip_address):
        "Add new hosts to a list if it doesn't already exist"
        if self.host_exists(host):
            logging.warning("'%s' already exists in %s, skipping", host, self.path)
            return False

        self.lines.append(HostLine.create(ip_address, host))

        return True

    def remove_host(self, host, ip_address):
        "Remove a host from the list"

        def _remove_host(line):
            if line.is_host:
                return line.host != host or line.ip != ip_address
            return True

        self.lines = filter(_remove_host, self.lines)

    @classmethod
    def parse_hosts_file(cls, path):
        "Parse a hosts file ``path`` and return a list of lines"
        return [HostLine(line) for line in get_file_lines(path)]


class HostLine(object):
    "Represents a single line from /etc/hosts"

    def __init__(self, value):
        self.value = value

    def __repr__(self):
        return self.value

    @classmethod
    def create(cls, ip_address, host):
        return cls("%s\t%s\n" % (ip_address, host))

    @property
    def is_host(self):
        return not self.value.startswith("#")

    @property
    def host_parts(self):
        if self.is_host:
            return re.split("\s+", self.value)

    @property
    def host(self):
        try:
            return self.host_parts[1]
        except IndexError:
            return None

    @property
    def ip(self):
        try:
            return self.host_parts[0]
        except IndexError:
            return None
