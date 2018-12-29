FROM python:alpine

ENV MYSQL_HOST mysql
ENV MYSQL_DATABASE --all-databases
ENV MYSQL_PORT 3306
ENV MYSQL_USER user
ENV MYSQL_PASSWORD password
ENV MYSQL_OPTIONS --quote-names --quick --add-drop-table --add-locks --allow-keywords --disable-keys --extended-insert --single-transaction --create-options --comments --net_buffer_length=16384

ENV S3_ACCESS_KEY_ID s3_id
ENV S3_SECRET_ACCESS_KEY s3_key
ENV S3_BUCKET s3_bucket
ENV S3_REGION us-east-1
ENV S3_ENDPOINT ""
ENV S3_PREFIX ""

ENV PERIOD "* 0 * * *"


RUN apk add --no-cache mysql-client openssh-client && \
    pip install awscli

COPY root/ /

WORKDIR /backup

RUN chmod -R +x /backup

CMD ./run.sh
