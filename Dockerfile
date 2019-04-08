FROM golang:1.12.1
RUN CGO_ENABLED=0 go get github.com/soundcloud/ipmi_exporter

FROM debian:stable-slim
RUN apt-get update && \
    apt-get install -y freeipmi && \
    rm -r /var/lib/apt/lists/*
COPY --from=0 /go/bin/ipmi_exporter /usr/local/bin/
EXPOSE 9290
ENTRYPOINT [ "ipmi_exporter" ]
