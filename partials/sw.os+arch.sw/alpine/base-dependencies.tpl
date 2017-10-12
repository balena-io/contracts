RUN apk add --update \
  bash \
  ca-certificates \
  dbus \
  findutils \
  openrc \
  tar \
  udev \
  tini \
  && rm -rf /var/cache/apk/*
