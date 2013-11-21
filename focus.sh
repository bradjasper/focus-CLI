#!/bin/bash
#
# Focus
#
# A simple script that blocks distracting websites in the firewall
#
# Utility script that's called by focus/unfocus scripts
#

BLOCKED_IDS="/tmp/.focus.blocked.ipfw.ids"

hostname_lookup() {
    host $1 | grep "has address" | awk '{print $4}'
}

block_ip() {
    ipfw add deny ip from me to $1 | awk '{print $1}' >> $BLOCKED_IDS
}

block_host() {
    hostname_lookup $1 | while read ip; do block_ip $ip; done
}

unblock_rule() {
    ipfw delete $1
}

unblock_all() {
    cat $BLOCKED_IDS | while read id; do unblock_rule $id; done
    rm $BLOCKED_IDS
}

focus_hosts() {
    cat $HOME/.focus | while read host; do printf "www.$host\n$host\n"; done
}

focus() {
    echo "Focusing...go be productive!"
    focus_hosts | while read host; do
        block_host $host;
    done
}

unfocus() {
    echo "Unfocusing..were you productive?"
    unblock_all
}

if [[ "$@" == "focus" ]]; then
    focus
elif [[ "$@" == "unfocus" ]]; then
    unfocus
fi
