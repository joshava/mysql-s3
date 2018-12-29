#!/bin/bash

set -e
set -o pipefail

DATE=$(date +%Y%m%d_%H%M%S)
DUMP="$MYSQL_DATABASE-$DATE.sql.gz"
mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -P $MYSQL_PORT $MYSQL_OPTIONS $MYSQL_DATABASE | gzip > $DUMP

export AWS_ACCESS_KEY_ID=$S3_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$S3_ACCESS_SECRET
export AWS_DEFAULT_REGION=$S3_REGION

if [[ -z "${S3_ENDPOINT}" ]]; then
    AWS_ARGS=""
else
    AWS_ARGS="--endpoint-url ${S3_ENDPOINT}"
fi


if [[ -z "${S3_PREFIX}" ]]; then
    AWS_PATH="s3://$S3_BUCKET/$DUMP"
else
    AWS_PATH="s3://$S3_BUCKET/$S3_PREFIX/$DUMP"
fi

cat $DUMP | aws $AWS_ARGS s3 cp - $AWS_PATH

rm $DUMP
