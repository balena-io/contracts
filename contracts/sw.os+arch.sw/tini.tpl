ENV TINI_VERSION {{sw.blob.tini.version}}
RUN curl -SLO "{{sw.blob.tini.assets.bin.url}}" \
  && echo "{{sw.blob.tini.assets.bin.checksum}}  {{sw.blob.tini.assets.bin.name}}" | sha256sum -c - \
  && tar -xzf "{{sw.blob.tini.assets.bin.name}}" \
  && rm "{{sw.blob.tini.assets.bin.name}}" \
  && chmod +x {{sw.blob.tini.assets.bin.main}} \
  && mv {{sw.blob.tini.assets.bin.main}} /sbin/{{sw.blob.tini.assets.bin.main}}

RUN mkdir -p /.resin && echo $'\n\
 __      ___   ___ _  _ ___ _  _  ___ \n\
 \ \    / /_\ | _ \ \| |_ _| \| |/ __|\n\
  \ \/\/ / _ \|   / .` || || .` | (_ |\n\
   \_/\_/_/ \_\_|_\_|\_|___|_|\_|\___|\n\
======================================\n\
resin base images have been deprecated\n\
in favour of the new balenalib images,\n\
read more about it in our docs:\n\
https://www.balena.io/docs/reference/base-images/base-images/\n\
======================================' > /.resin/deprecation-warning

ONBUILD RUN cat /.resin/deprecation-warning
