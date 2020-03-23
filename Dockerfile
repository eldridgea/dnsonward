FROM alpine
RUN apk add sed
ADD https://github.com/coredns/coredns/releases/download/v1.6.7/coredns_1.6.7_linux_amd64.tgz /coredns-x86_64.tgz
ADD https://github.com/coredns/coredns/releases/download/v1.6.7/coredns_1.6.7_linux_arm.tgz /coredns-arm.tgz
RUN tar xvzf /coredns-x86_64.tgz && mv /coredns /coredns-x86_64 && tar xvzf /coredns-arm.tgz && mv /coredns /coredns-arm
RUN rm /coredns-x86_64.tgz && rm /coredns-arm.tgz
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
