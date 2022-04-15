#Директива переноса строки:
# escape=\

# Базовый образ с которого мы начинаем создание своего собственного:
#FROM nginx:latest
FROM alpine

# обновляем и устанавливаем необходимые пакеты
RUN apk update \
    && apk add nginx \
    && apk add curl

# Добавить мета информацию к образу
LABEL version="0.0.1" \
      maintainer="aleks_sh"

#timestamp на локальном хосте соответствовало timestamp в docker
ENV TZ=Europe/Moscow

# Создаю переменную WORKDIR, которой присваиваю путь
ENV WORKDIR /usr/share/nginx/html/

# Домашний каталог контейнера, который ссылается на нашу переменную WORKDIR
WORKDIR ${WORKDIR}

# ещё одна команда котора создаёт символическу ссылку
# которая фактически будет выводить log nginx в консоль
RUN ln -sf /dev/stdout /var/log/nginx/access.log

#Копирует все в каталог /usr/share/nginx/html
COPY ./nginx/html .
COPY ./nginx/config/default.conf /etc/nginx/conf.d/
COPY ./nginx/config/nginx.conf /etc/nginx/

#Открываем порты:
#EXPOSE 80

# Команда которая будет запущена при старте нашего контейнера
CMD ["nginx", "-g", "daemon off;"]

# Проверка ответа по 80 порту
HEALTHCHECK --retries=3 --interval=3s \
  CMD curl -f http://localhost:80/ || exit 1
