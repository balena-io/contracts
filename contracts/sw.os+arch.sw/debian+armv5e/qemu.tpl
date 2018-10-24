ENV QEMU_CPU arm1026
LABEL io.balena.qemu.version="{{sw.blob.qemu.version}}"
COPY {{sw.blob.qemu.assets.bin.main}} /usr/bin
