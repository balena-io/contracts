RUN apk add --update \
		less \
		nano \
		net-tools \
		usbutils \
		gnupg \
	&& (apk add --no-cache ifupdown || apk add --no-cache ifupdown-ng) \
	&& rm -rf /var/cache/apk/*
