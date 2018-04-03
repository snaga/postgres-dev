#!/bin/sh

PGHOME=/usr/local/pgsql
PGDATA=/var/lib/pgsql/11/data

PATH=$PGHOME/bin:$PATH
export PATH

echo postgres > /tmp/pwfile
initdb -D $PGDATA --no-locale -E utf-8 -k --pwfile /tmp/pwfile
rm /tmp/pwfile

sed -i -e "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" $PGDATA/postgresql.conf
sed -i -e "s/#logging_collector = off/logging_collector = on/" $PGDATA/postgresql.conf

sed -i -e "s,host    all             all             127.0.0.1/32            trust,host    all             all             127.0.0.1/32            trust\nhost    all             all             0.0.0.0/0               md5," $PGDATA/pg_hba.conf

postgres -D $PGDATA

