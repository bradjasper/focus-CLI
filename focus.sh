#!/bin/bash

#
# Focus
#
# A simple script to add hostnames in $HOME/.focus to your /etc/hosts file
# under the host name 127.0.0.1 so you can't visit them....so you focus :)
#

HOSTS_FILE=/etc/hosts
HOSTS_FILE_BAK=$HOSTS_FILE.bak
ACTIVATION_HOST="focus_activation_host"
HOSTS_IP="127.0.0.1"

focus_hosts() {
    cat $HOME/.focus | while read host; do
        echo -n " $host www.$host";
    done
}

hosts_line() {
    echo "$HOSTS_IP $(focus_hosts) $ACTIVATION_HOST"
}

backup_hosts_file() {
    sudo cp $HOSTS_FILE $HOSTS_FILE_BAK
}

focus() {
    backup_hosts_file \
        && sudo -s "echo $(hosts_line) >> $HOSTS_FILE" \
        && echo "Focusing...go be productive!"
}

unfocus() {
    backup_hosts_file \
        && sudo -s "sed '/$ACTIVATION_HOST/d' $HOSTS_FILE_BAK > $HOSTS_FILE" \
        && echo "Unfocusing..were you productive?"
}
