ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
COPY 01_nodoc /etc/dpkg/dpkg.cfg.d/
COPY 01_buildconfig /etc/apt/apt.conf.d/
RUN mkdir -p /usr/share/man/man1
