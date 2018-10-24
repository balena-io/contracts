# Install packages for build variant
RUN apk add --update \
		bzr \
		git \
		mercurial \
		openssh-client \
		subversion \
		ca-certificates \
		curl \
		wget \
		autoconf \
		build-base \
		imagemagick \
		libbz2 \
		libevent-dev \
		libffi-dev \
		glib-dev \
		jpeg-dev \
		imagemagick-dev \
		ncurses5-libs \
		libpq \
		readline-dev \
		sqlite-dev \
		openssl-dev \
		libxml2-dev \
		libxslt-dev \
		yaml-dev \
		zlib-dev \
		xz \
	&& rm -rf /var/cache/apk/*
