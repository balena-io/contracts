RUN apt-get update && apt-get install -y --no-install-recommends \
  sudo \
  ca-certificates \
  findutils \
  gnupg \
  dirmngr \
  inetutils-ping \
  iproute \
  netbase \
  curl \
  udev \
  && rm -rf /var/lib/apt/lists/*
