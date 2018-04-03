#!/bin/sh

curl -s -L 'https://git.postgresql.org/gitweb/?p=postgresql.git;a=rss;h=refs/heads/master' | grep pubDate | head -1 > latest.txt
diff -rc latest.txt last.txt > /dev/null

if [ $? -ne 0 ]; then
    curl -u ${CIRCLE_API_TOKEN}: \
	-d build_parameters[CIRCLE_JOB]=build \
	https://circleci.com/api/v1.1/project/github/snaga/postgres-dev/tree/master
fi

mv latest.txt last.txt
