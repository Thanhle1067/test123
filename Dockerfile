FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    tar \
    ca-certificates \
    libuv1t64 \
    hwloc \
    libhwloc-dev && \
    ldconfig && \
    rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh

RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
