RUN dnf install -y \
		less \
		nano \
		net-tools \
		usbutils \
		gnupg \
		i2c-tools \
		libartik-sdk-tests \
		libartik-sdk-zigbee-devel \
	&& dnf clean all
