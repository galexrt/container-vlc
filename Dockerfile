FROM fedora:36

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
    dnf upgrade -y && \
    rpm -ivh "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-36.noarch.rpm" && \
    dnf upgrade -y && \
    dnf install -y vlc ffmpeg && \
    dnf clean all

USER "vlc"

WORKDIR "/data"

VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/cvlc"]
