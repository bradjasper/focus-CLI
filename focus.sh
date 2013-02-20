#!/bin/bash

#
# Focus
#
# A simple script to add hostnames in $HOME/.focus to your /etc/hosts file
# under the host name 127.0.0.1 so you can't visit them....so you focus :)
#

focus_hosts() {
    cat $HOME/.focus | while read host; do
        echo -n " $host www.$host";
    done
}

hosts_line() {
    echo "127.0.0.1 $(focus_hosts) focus_activation_host"
}

backup_hosts_file() {
    sudo cp /etc/hosts /etc/hosts.bak
}

focus() {
    backup_hosts_file \
        && sudo -s "echo $(hosts_line) >> /etc/hosts" \
        && echo "Focusing...go be productive!"
}

unfocus() {
    backup_hosts_file \
        && sudo -s "sed '/focus_activation_host/d' /etc/hosts.bak > /etc/hosts" \
        && echo "Unfocusing..were you productive?"
}
