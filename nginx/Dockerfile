FROM nginx:alpine

ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache

COPY default.conf /etc/nginx/conf.d/default.conf

ARG PHP_FPM_PORT
ARG BACKEND_PORT

RUN sed -i "s/3002/${PHP_FPM_PORT}/" /etc/nginx/conf.d/default.conf
RUN sed -i "s/3001/${BACKEND_PORT}/" /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html
