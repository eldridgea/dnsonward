# DNS-Onward
A CoreDNS based service that forwards traditional DNS requests to a DNS-over-TLS upstream server

## Quickstart

Run `docker run -e SERVICE="cloudflare" -p 53:53 -p 53:53/udp eldridgea/dnsonward`

This will start the service using Cloudflare as its upstream DNS server. You can replace "cloudflare" in the line above with either "google" or "quad9" to use their servers instead.
This will open up port 53 on your machine and allow it to accept incoming DNS requests.
enviornments

>WARNING: It is NOT recommended to expose this serivce as-is to the entire Intenet. This is intended for private/controlled network environments. 

## Suported Devices and Architectures

This supports ARM and x86_64. This works on most servers as well as Raspbrry Pis.
I have tested it successfully on my Pi 4 running Raspbian 10. If you're having an issue on other Pi hardware/OS versions please open an issue.

## Variables

This is CoreDNS-based service intended to be run in enviornments where traditional DNS requests need to be encrypted before querying an upstream server.

This is intended to be run as a docker container and configured with enviornment variables.

Onward DNS supports Cloudflare, Google, and Quad9 out of the box with the `SERVICE` variable, but can also be configured for any DnS-over-TLS (DoT) server.

If you are starting this container you should either supply it with the `SERVICE` environment variable OR supply it with at least the `IP1` and `SERVERNAME` variables.

| Env Variable  | Function      | Values|
| ------------- |:-------------|:-----|
| SERVICE       | Auto configures Onward DNS based on supported services | `google`, `cloudflare`, and `quad9` |
| IP1           | A primary upstream DNS IP Address         |   Any IPv4 Address |
| IP2           | A secondary upstream DNS IP Address       |   Any IPv4 Address |
| SERVERNAME    | The TLS servername                        | The domain name of the DoT server |
| CACHE         | The amount of time DNS responses are cahced locally | Time in seconds e.g. `100s`. Default is `30s` |
