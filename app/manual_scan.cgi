#! /bin/sh

echo "Content-type: text/plain"
echo ""

if [ -f /tmp/scan_in_progress ]; then
    echo "A scan is already in progress:"
    cat /var/log/duc.log
elif [ -f /tmp/scan_requested ]; then
    echo "A manual scan has already been requested and will be started in less than one minute"
else
    touch /tmp/scan_requested
    echo "A scan will be started in less than one minute"
fi