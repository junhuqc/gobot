FROM ubuntu:16.04

ENV GOPATH /go
ENV WORKINGPATH $GOPATH/src/github.com/junhuqc/gobot

COPY . $WORKINGPATH

RUN apt-get update \
    && apt-get install -y libczmq-dev golang


WORKDIR $WORKINGPATH

ENTRYPOINT ["tail -f /dev/null"]
