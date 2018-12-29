#!/bin/bash

set -e
set -o pipefail

sed -i "s/{{PERIOD}}/$PERIOD/g" /var/spool/cron/crontabs/root
./dump.sh
crond -f
