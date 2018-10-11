ENV UDEV off
ENV DBUS_SYSTEM_BUS_ADDRESS unix:path=/run/dbus/system_bus_socket

# Few tweaks for Fedora base image
RUN mkdir -p /etc/dnf/vars \
    && echo "armhfp" > /etc/dnf/vars/basearch \
    && echo "armv7hl" > /etc/dnf/vars/arch
