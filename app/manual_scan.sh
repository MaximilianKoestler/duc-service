#! /bin/sh

if [ -f /tmp/scan_requested ]; then
    rm -f /tmp/scan_requested
    /scan.sh
fi
