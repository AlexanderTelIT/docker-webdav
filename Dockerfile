FROM ubuntu:xenial-20170410
USER root

ENV WEBDAV_USERNAME="Test" 
ENV WEBDAV_PASSWORD="Test"
ARG http_proxy
ARG https_proxy
RUN apt-get update \
 && apt-get install -yq --no-install-recommends nginx-extras gosu apache2-utils \
 && rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stderr /var/log/nginx/error.log
RUN chmod -R 7777  /var /run
VOLUME /media

COPY entrypoint.sh /
COPY nginx.conf /etc/nginx/
RUN chmod -R 7777 /etc/
RUN chmod -R 7777 /etc/nginx
RUN mkdir -p /media/.tmp

RUN chmod -R 7777 /media/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
