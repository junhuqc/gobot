FROM ubuntu:16.04

ENV GOPATH /go
ENV WORKINGPATH $GOPATH/src/github.com/junhuqc/gobot

COPY ./docker-entrypoint.sh /
COPY . $WORKINGPATH

RUN apt-get update \
    && apt-get install -y libczmq-dev golang


WORKDIR $WORKINGPATH

ENTRYPOINT ["/docker-entrypoint.sh"]
