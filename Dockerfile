FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -qy install cmake make build-essential libboost-dev \
        libboost-program-options-dev libssl-dev libtool git librabbitmq-dev && \
    mkdir /src

WORKDIR "/src"
RUN git clone https://github.com/velovec/libbloom
WORKDIR "/src/libbloom"
RUN make

COPY . /src/bloomgenerator/
WORKDIR "/src/bloomgenerator"

RUN cmake . && make

VOLUME ["/bloom_data"]
WORKDIR "/bloom_data"

ENTRYPOINT ["/src/bloomgenerator/bloomgenerator"]
