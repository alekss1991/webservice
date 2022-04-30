#!/bin/bash

# Создать образ на основании Dockerfile:
podman build ${PWD} \
 -t 12aleks211/webservice:0.0.1 \
 -t 12aleks211/webservice:latest

#Запускаем собранный контейнер + пробрасываем тома:
podman container run -d \
 -p 80:80 \
 -v ${PWD}/nginx/html:/usr/share/nginx/html \
 --health-cmd 'curl http://localhost:80/' \
 --health-retries 3 --health-interval '1s' \
 12aleks211/webservice:latest

podman ps -a
sleep 3
echo '++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
podman ps -a

echo -n "Do you want push the image to Docker Hub? [y/n]?: "
read VAR_PUSH_DH

if [[ $VAR_PUSH_DH = 'y' ]]
then
  podman image push --all-tags 12aleks211/webservice
elif [[  $VAR_PUSH_DH = 'n' ]]
then
  echo "Skip pushing.."
else
  echo "You entered something wrong! Skip pushing.."
fi
