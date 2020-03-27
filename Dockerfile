FROM golang:1.12
RUN mkdir /v && cd /v && git clone https://github.com/coredns/coredns.git
RUN cd /v/coredns && make

FROM alpine

COPY --from=0 /v/coredns/coredns /coredns

RUN apk add sed
RUN mkdir /coredns-config
COPY *.template /coredns-config/
COPY setup.sh /coredns-config/setup.sh
ARG IP1
ARG IP2
ARG SERVERNAME
ARG SERVICE
ARG CACHE
EXPOSE 53 53/udp
CMD cd /coredns-config; /coredns-config/setup.sh ; /coredns -conf /coredns-config/Corefile
