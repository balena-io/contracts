RUN apk add --update \
		less \
		nano \
		net-tools \
		usbutils \
		gnupg \
		raspberrypi \
		raspberrypi-libs \
		raspberrypi-dev \
	&& (apk add --no-cache ifupdown || apk add --no-cache ifupdown-ng) \
	&& rm -rf /var/cache/apk/*
