FROM nginx

ADD bin/    /usr/local/share/nginx-templated/bin/
ADD static/ /usr/local/share/nginx-templated/html/

RUN apt-get -y update        \
    && apt-get -y upgrade    \
    && apt-get -y autoremove \
    && apt-get -y autoclean  \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

env PATH $PATH:/usr/local/share/nginx-templated/bin

RUN configure-nginx.sh

VOLUME ["/etc/nginx/sites-templates"]
WORKDIR /etc/nginx

ENTRYPOINT ["entrypoint.sh"]
CMD ["nginx"]
