#! /bin/sh

touch /var/log/duc.log

echo "Starting initial recursive scan"
echo "This may take a while..."
echo "Now: $(date)"
/scan.sh
echo "Now: $(date)"
echo "Scan complete"

echo "Creating cron schedule: $SCHEDULE"
echo "* * * * * root /manual_scan.sh" >> /etc/cron.d/duc-index
echo "$SCHEDULE root /scan.sh" >> /etc/cron.d/duc-index
chmod 0644 /etc/cron.d/duc-index
cron

echo "Launching webserver"
/etc/init.d/fcgiwrap start
nginx
