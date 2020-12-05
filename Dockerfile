FROM fedora:33
LABEL maintainer="Alexander Trost <galexrt@googlemail.com>"

ARG VLC_UID="1000"
ARG VLC_GID="1000"

RUN groupadd -g "$VLC_GID" vlc && \
    useradd -m -d /data -s /bin/sh -u "$VLC_UID" -g "$VLC_GID" vlc && \
    dnf upgrade -y && \
    rpm -ivh "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-33.noarch.rpm" && \
    dnf upgrade -y && \
    dnf install -y vlc && \
    dnf clean all

USER "vlc"

WORKDIR "/data"
VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/vlc"]
