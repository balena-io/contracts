RUN apt-get update && apt-get install -y --no-install-recommends \
  sudo \
  ca-certificates \
  findutils \
  gnupg \
  dirmngr \
  inetutils-ping \
  netbase \
  curl \
  udev \
  $( \
      if apt-cache show 'iproute' 2>/dev/null | grep -q '^Version:'; then \
        echo 'iproute'; \
      else \
        echo 'iproute2'; \
      fi \
  ) \
  && rm -rf /var/lib/apt/lists/* \
  && echo '#!/bin/sh\n\
set -e\n\
set -u\n\ 
export DEBIAN_FRONTEND=noninteractive\n\
n=0\n\
max=2\n\
until [ $n -gt $max ]; do\n\
  set +e\n\
  (\n\
    apt-get update -qq &&\n\
    apt-get install -y --no-install-recommends "$@"\n\
  )\n\
  CODE=$?\n\
  set -e\n\
  if [ $CODE -eq 0 ]; then\n\
    break\n\
  fi\n\
  if [ $n -eq $max ]; then\n\
    exit $CODE\n\
  fi\n\
  echo "apt failed, retrying"\n\
  n=$(($n + 1))\n\
done\n\
rm -r /var/lib/apt/lists/*' > /usr/sbin/install_packages \
  && chmod 0755 "/usr/sbin/install_packages"
