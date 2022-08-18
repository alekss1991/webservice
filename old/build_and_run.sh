#!/bin/bash

# Создать образ на основании Dockerfile:
docker build ${PWD} \
 -t 12aleks211/webservice:0.0.1 \
 -t 12aleks211/webservice:latest

#Запускаем собранный контейнер + пробрасываем тома:
docker container run -d \
 -p 80:80 \
 -v ${PWD}/nginx/html:/usr/share/nginx/html \
 --restart on-failure \
 12aleks211/webservice:0.0.1

docker container ps -a
sleep 3
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
docker container ps -a
