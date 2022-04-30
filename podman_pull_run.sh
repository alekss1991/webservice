#!/bin/bash

#Запускаем собранный контейнер + пробрасываем тома:
podman container run -d \
 -p 80:80 \
 -v ${PWD}/nginx/html:/usr/share/nginx/html \
 --health-cmd 'curl http://localhost:80/' \
 --health-retries 3 --health-interval '1s' \
 docker.io/12aleks211/webservice:latest

podman ps -a
sleep 3
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
podman ps -a
