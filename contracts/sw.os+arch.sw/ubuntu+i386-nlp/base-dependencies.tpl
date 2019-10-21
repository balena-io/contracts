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
rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*' > /usr/sbin/install_packages \
  && chmod 0755 "/usr/sbin/install_packages"

RUN set -x \
  && buildDeps='git-core autoconf libtool automake build-essential debhelper fakeroot cmake dpkg-dev devscripts' \
  && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
  && git clone https://github.com/mdr78/libx1000.git \
  && cd libx1000 \
  && git checkout 1bfb62bb62e0ebe0e42817edd9702d91d232dbee \
  && cd libx1000-0.0.0 \
  && libtoolize --force \
  && aclocal \
  && autoheader \
  && automake --force-missing --add-missing \
  && autoconf \
  && ./autogen.sh \
  && ./configure \
  && make && make install \
  && apt-get purge -y --auto-remove $buildDeps \
  && cd / && rm -rf /libx1000

{{import partial=sw.stack-variant.slug combination="sw.os+arch.sw"}}
