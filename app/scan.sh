#! /bin/sh

if [ ! -f /tmp/scan_in_progress ]; then
    touch /tmp/scan_in_progress

    echo "Start of scan: $(date)" > /var/log/duc.log
    /usr/local/bin/duc index --progress /scan >> /var/log/duc.log 2>&1
    echo "End of scan: $(date)" >> /var/log/duc.log

    rm -f /tmp/scan_in_progress
fi
