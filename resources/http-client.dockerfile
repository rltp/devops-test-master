FROM alpine/curl
USER root

WORKDIR /http-client
COPY . .

WORKDIR /usr/local/http-client
ADD http-client .