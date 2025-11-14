FROM docker.io/library/rockylinux:9.3

ARG BUILD_DATE="N/A"
ARG REVISION="N/A"

ARG VLC_UID="1000"
ARG VLC_GID="1000"

ENV HOME="/data"

LABEL org.opencontainers.image.authors="Alexander Trost <galexrt@googlemail.com>" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.title="galexrt/container-vlc" \
    org.opencontainers.image.description="[VLC Media Player](https://www.videolan.org/vlc/) in a Container Image." \
    org.opencontainers.image.documentation="https://github.com/galexrt/container-vlc/blob/main/README.md" \
    org.opencontainers.image.url="https://github.com/galexrt/container-vlc" \
    org.opencontainers.image.source="https://github.com/galexrt/container-vlc" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.vendor="galexrt" \
    org.opencontainers.image.version="N/A"

RUN groupadd -g "${VLC_GID}" vlc && \
    useradd -m -d /data -s /bin/sh -u "${VLC_UID}" -g "${VLC_GID}" vlc && \
    dnf install -y epel-release && \
    dnf config-manager --set-enabled crb && \
    dnf install -y --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm && \
    dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm && \
    dnf upgrade -y && \
    dnf install -y vlc ffmpeg && \
    dnf clean all

USER "vlc"

WORKDIR "/data"

VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/cvlc"]
