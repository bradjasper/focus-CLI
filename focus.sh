#!/bin/bash
#
# Focus
#
# A simple script to add hostnames in $HOME/.focus to your /etc/hosts file
# under the host name 127.0.0.1 so you can't visit them....so you focus :)
#
# Utility script that's called by focus/unfocus scripts
#

backup_hosts_file() {
    cp /etc/hosts /etc/hosts.bak
}

add_hosts_line() {
    echo "127.0.0.1 $(focus_hosts) focus_activation_host" >> /etc/hosts
}

delete_hosts_line() {
    sed '/focus_activation_host/d' /etc/hosts.bak > /etc/hosts
}

focus_hosts() {
    cat $HOME/.focus | while read host; do
        echo -n " $host www.$host";
    done
}

if [[ "$@" == "focus" ]]; then
    backup_hosts_file && add_hosts_line && echo "Focusing...go be productive!"
elif [[ "$@" == "unfocus" ]]; then
    backup_hosts_file && delete_hosts_line && echo "Unfocusing..were you productive?"
fi
