# Docker Container for PostgreSQL-dev

[![CircleCI](https://circleci.com/gh/snaga/postgres-dev/tree/master.svg?style=svg)](https://circleci.com/gh/snaga/postgres-dev/tree/master)

Pull and run to try it out.
```
$ docker pull uptimejp/postgres-dev
$ docker run -p 5434:5432 -d -t uptimejp/postgres-dev
$ psql -h localhost -p 5434 -U postgres postgres
```

EOF
