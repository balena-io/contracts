ENV QEMU_CPU arm1026
LABEL io.resin.qemu.version="{{sw.blob.qemu.version}}"
COPY {{sw.blob.qemu.assets.bin.main}} /usr/bin