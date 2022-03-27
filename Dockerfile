FROM docker.velovec.pro/btc/supervisor-base:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -qy install cmake make build-essential libboost-dev \
    libboost-program-options-dev libssl-dev libtool git librabbitmq-dev cron

COPY supervisor/bloomgenerator.conf /etc/supervisor/conf.d/bloomgenerator.conf
COPY supervisor/crontab /etc/crontab

WORKDIR "/src"
RUN git clone https://github.com/velovec/libbloom
WORKDIR "/src/libbloom"
RUN make

COPY . /src/bloomgenerator/
WORKDIR "/src/bloomgenerator"

RUN cmake . && make

VOLUME ["/bloom_data"]
