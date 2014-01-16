#!/bin/bash
#
# Focus
#
# A simple script that blocks distracting websites in the firewall
#
# Utility script that's called by focus/unfocus scripts
#

FOCUS_FILE=/Users/$USER/.focus
FOCUS_PAC_FILE=$FOCUS_FILE.pak

# Figure out which Network is active
FOCUS_SERVICE_GUID=`echo "open|||get State:/Network/Global/IPv4|||d.show" | \
    tr '|||' '\n' | scutil | grep "PrimaryService" | awk '{print $3}'`
FOCUS_SERVICE_NAME=`echo "open|||get Setup:/Network/Service/$FOCUS_SERVICE_GUID|||d.show" |\
    tr '|||' '\n' | scutil | grep "UserDefinedName" | awk -F': ' '{print $2}'`

focus() {
    echo "Focusing...go be productive!"
    write_pac_file
    networksetup -setautoproxyurl "$FOCUS_SERVICE_NAME" "file://$FOCUS_PAC_FILE"
}

unfocus() {
    echo "Unfocusing..were you productive?"
    networksetup -setautoproxyurl "$FOCUS_SERVICE_NAME" null
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

read_pac_file() {
    networksetup -getautoproxyurl "$FOCUS_SERVICE_NAME" | head -n1 | awk '{print $2}'
}

focus_is_active() {
    local currFile=$(read_pac_file)
    local focusFile="file://$FOCUS_PAC_FILE"
    if [ "$currFile" == "$focusFile" ]
    then
        return 0
    else
        return 1
    fi
}


if [[ "$@" == "focus" ]]; then
    focus
elif [[ "$@" == "unfocus" ]]; then
    unfocus
elif [[ "$@" == "current_pac_file" ]]; then
    read_pac_file
elif [[ "$@" == "status" ]]; then
    if focus_is_active
    then
        echo "active"
    else
        echo "inactive"
    fi
fi
