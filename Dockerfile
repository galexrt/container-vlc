FROM fedora:27

RUN useradd -m -d /data -s /bin/sh -u 1000 vlc && \
    rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm && \
    dnf upgrade -y && \
    dnf install -y vlc

USER "vlc"

VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/vlc"]
