all:
	docker build -t postgres-dev .

run:
	docker run -ti postgres-dev /bin/bash

