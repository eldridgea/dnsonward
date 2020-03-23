FROM alpine
RUN apk add sed
ADD https://github.com/coredns/coredns/releases/download/v1.6.7/coredns_1.6.7_linux_amd64.tgz /coredns.tgz
RUN tar xvzf /coredns.tgz
RUN rm /coredns.tgz
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
