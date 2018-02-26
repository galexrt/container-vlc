FROM fedora:27

LABEL maintainer="Alexander Trost <galexrt@googlemail.com>"

RUN useradd -m -d /data -s /bin/sh -u 1000 vlc && \
    dnf upgrade -y && \
    rpm -ivh "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-27.noarch.rpm" && \
    dnf upgrade -y && \
    dnf install -y vlc && \
    dnf clean all

USER "vlc"

VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/vlc"]
