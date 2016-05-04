FROM ubuntu:14.04.4

RUN add-apt-repository ppa:chris-lea/zeromq \
    && apt-get update \
    && apt-get install -y software-properties-common \
    && apt-get update \
    && apt-get install -y libzmq3-dbg libzmq3-dev libzmq3


CMD ["tail -f /dev/null"]
