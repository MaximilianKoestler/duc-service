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
rm -f /var/run/fcgiwrap.socket
nohup fcgiwrap -s unix:/var/run/fcgiwrap.socket &
while ! [ -S /var/run/fcgiwrap.socket ]; do sleep .2; done
chmod 777 /var/run/fcgiwrap.socket
test -f nohup.out && rm ./nohup.out

nginx