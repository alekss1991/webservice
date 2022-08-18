#!/bin/bash

# Создать образ на основании Dockerfile:
docker build ${PWD} \
 -t localhost:5000/nginx:0.0.1 \
 -t localhost:5000/nginx:latest

#Запускаем собранный контейнер + пробрасываем тома:
docker run -d \
 -p 80:80 \
 -v ${PWD}/nginx/html:/usr/share/nginx/html \
 -v ${PWD}/nginx/log:/var/log/nginx \
 localhost:5000/nginx:0.0.1


