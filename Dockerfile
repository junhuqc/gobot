FROM golang:1.6.2-alpine 

ENV ZMQ_VERSION 4.1.4
ENV CZMQ_VERSION 3.0.2

RUN apk update \
    && apk add --no-cache \
           gcc libtool zlib make musl-dev openssl-dev zlib-dev g++ curl tar gnupg


WORKDIR  /tmp
RUN curl -L https://download.libsodium.org/libsodium/releases/libsodium-1.0.10.tar.gz -o libsodium.tar.gz \
    && curl -L https://download.libsodium.org/libsodium/releases/libsodium-1.0.10.tar.gz.sig -o libsodium.sig \
    && curl -L https://download.libsodium.org/jedi.gpg.asc -o jedi.gpg.asc \
    && gpg --import jedi.gpg.asc \
    && gpg --verify libsodium.sig libsodium.tar.gz \
    && tar -xf libsodium.tar.gz \
    && cd /tmp/libsodium*/ \
    && ./configure \
    && make check \
    && make install

WORKDIR  /tmp	 
RUN curl -L http://download.zeromq.org/zeromq-${ZMQ_VERSION}.tar.gz -o zeromq.tar.gz \
    && tar -xf zeromq.tar.gz \
    && cd /tmp/zeromq*/ \
    && ./configure --with-libsodium \
    && make && make check && make install
    
WORKDIR /tmp
RUN curl -L http://download.zeromq.org/czmq-${CZMQ_VERSION}.tar.gz -o czmq.tar.gz \
    && tar -xf czmq.tar.gz \
    && cd /tmp/czmq*/ \
    && ./configure \
    && make check && make install \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

WORKDIR /go/src/github.com/junhuqc/gobot