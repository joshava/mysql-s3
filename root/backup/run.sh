#!/bin/sh

sed -i "s/{{PERIOD}}/$PERIOD/g" /var/spool/cron/crontabs/root
./dump.sh
crond -f
