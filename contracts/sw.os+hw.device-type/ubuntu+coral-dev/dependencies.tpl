RUN apt-get update && apt-get install -y --no-install-recommends \
        less \
        kmod \
        nano \
        net-tools \
        ifupdown \
        iputils-ping \
        i2c-tools \
        usbutils \
        apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

# Add Google Coral sources lists
RUN echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | tee /etc/apt/sources.list.d/coral-edgetpu.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Install the TPU packages
RUN install_packages  libedgetpu1-std \
        python3-edgetpu \
        libedgetpu-dev

RUN echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="1a6e", GROUP="plugdev"' >> /etc/udev/rules.d/99-tpu.rules \
    && echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", GROUP="plugdev"' >> /etc/udev/rules.d/99-tpu.rules