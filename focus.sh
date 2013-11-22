#!/bin/bash
#
# Focus
#
# A simple script that blocks distracting websites in the firewall
#
# Utility script that's called by focus/unfocus scripts
#

FOCUS_FILE=$HOME/.focus
FOCUS_PAC_FILE=$FOCUS_FILE.pak

focus() {
    echo "Focusing...go be productive!"
    write_pac_file
    networksetup -setautoproxyurl "Wi-Fi" "file://$FOCUS_PAC_FILE"
}

unfocus() {
    echo "Unfocusing..were you productive?"
    networksetup -setautoproxyurl "Wi-Fi" null
}

focus_hosts() {
    cat $FOCUS_FILE | while read host; do printf "www.$host\n$host\n"; done
}

write_pac_file() {
    echo 'function FindProxyForURL(url, host) {' > $FOCUS_PAC_FILE
    focus_hosts | while read host; do
        echo "    if (dnsDomainIs(host,'$host')) return 'PROXY localhost:8080';"
    done >> $FOCUS_PAC_FILE
    echo "    return 'DIRECT';" >> $FOCUS_PAC_FILE
    echo "}" >> $FOCUS_PAC_FILE
}

if [[ "$@" == "focus" ]]; then
    focus
elif [[ "$@" == "unfocus" ]]; then
    unfocus
fi
