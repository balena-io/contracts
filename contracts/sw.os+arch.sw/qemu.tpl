
LABEL io.resin.qemu.version="{{sw.blob.qemu.version}}"
COPY {{sw.blob.qemu.assets.bin.main}} /usr/bin

ONBUILD RUN echo 'WARNING: resin base images is now deprecated!\nAll base images are moved to new namespace "balenalib". Please check our docs(https://www.balena.io/docs) or new dockerhub namespace(https://hub.docker.com/u/balenalib/) for more details.'
