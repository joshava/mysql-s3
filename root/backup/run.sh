#!/bin/bash

set -e
set -o pipefail

sed -i "s/{{PERIOD}}/$PERIOD/g" /var/spool/cron/crontabs/root

if [[ $RUN ]]; then
    ./dump.sh
fi

crond -f
