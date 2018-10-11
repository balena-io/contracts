ENV LC_ALL C.UTF-8
ENV UDEV off
ENV DBUS_SYSTEM_BUS_ADDRESS unix:path=/run/dbus/system_bus_socket

RUN mkdir -p /usr/share/man/man1
