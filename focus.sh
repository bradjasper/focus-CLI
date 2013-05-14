#!/bin/bash
#
# Focus
#
# A simple script to add hostnames in $HOME/.focus to your /etc/hosts file
# under the host name 127.0.0.1 so you can't visit them....so you focus :)
#
# Utility script that's called by focus/unfocus scripts
#

# A unique identifier to let us know which host lines are safe to delete
FOCUS_HOST_IDENTIFIER="focus_activation_host"

backup_hosts_file() {
    cp /etc/hosts /etc/hosts.bak
}

add_hosts_line() {
    echo "127.0.0.1    $(focus_hosts) $FOCUS_HOST_IDENTIFIER" >> /etc/hosts
    echo "::1    $(focus_hosts) $FOCUS_HOST_IDENTIFIER" >> /etc/hosts
}

delete_hosts_line() {
    sed "/$FOCUS_HOST_IDENTIFIER/d" /etc/hosts.bak > /etc/hosts
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
