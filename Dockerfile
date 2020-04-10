FROM golang:1.14
RUN git clone https://github.com/coredns/coredns /coredns
RUN cd /coredns && make

FROM alpine

COPY --from=0 /coredns/coredns /coredns

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
