RUN dnf update -y && dnf install -y \
  ca-certificates \
  findutils \
  gnupg \
  hostname \
  tar \
  udev \
  which \
  curl \
  iproute \
  && dnf clean all \
  && echo $'#!/bin/sh\n\
set -e\n\
set -u\n\
n=0\n\
max=2\n\
until [ $n -gt $max ]; do\n\
  set +e\n\
  (\n\
    dnf update -y &&\n\
    dnf install -y "$@"\n\
  )\n\
  CODE=$?\n\
  set -e\n\
  if [ $CODE -eq 0 ]; then\n\
    break\n\
  fi\n\
  if [ $n -eq $max ]; then\n\
    exit $CODE\n\
  fi\n\
  echo "dnf failed, retrying"\n\
  n=$(($n + 1))\n\
done\n\
dnf clean all' > /usr/sbin/install_packages \
  && chmod 0755 "/usr/sbin/install_packages"

{{import partial=sw.stack-variant.slug combination="sw.os+arch.sw"}}
