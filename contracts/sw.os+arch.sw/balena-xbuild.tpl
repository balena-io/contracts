RUN curl -SLO "{{sw.blob.balena-xbuild.assets.bin.url}}" \
  && echo "{{sw.blob.balena-xbuild.assets.bin.checksum}}  {{sw.blob.balena-xbuild.assets.bin.name}}" | sha256sum -c - \
  && tar -xzf "{{sw.blob.balena-xbuild.assets.bin.name}}" \
  && rm "{{sw.blob.balena-xbuild.assets.bin.name}}" \
  && chmod +x {{sw.blob.balena-xbuild.assets.bin.main}} \
  && mv {{sw.blob.balena-xbuild.assets.bin.main}} /usr/bin \
  && ln -s {{sw.blob.balena-xbuild.assets.bin.main}} /usr/bin/cross-build-start \
  && ln -s {{sw.blob.balena-xbuild.assets.bin.main}} /usr/bin/cross-build-end
