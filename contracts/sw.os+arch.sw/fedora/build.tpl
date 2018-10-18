# Install packages for build variant
RUN dnf install -y \
		ca-certificates \
		curl \
		wget \
		bzr \
		git \
		mercurial \
		openssh-clients \
		subversion \
		autoconf \
		automake \
		bzip2-devel \
		glib2-devel \
		gcc \
		gcc-c++ \
		ImageMagick \
		ImageMagick-devel \
		kernel-devel \
		libcurl-devel \
		libevent-devel \
		libffi-devel \
		libjpeg-devel \
		libsqlite3x-devel \
		libxml2-devel \
		libxslt-devel \
		libyaml-devel \
		mysql-devel \
		make \
		ncurses-devel \
		openssl-devel \
		postgresql-devel \
		readline-devel \
		sqlite-devel \
		zlib-devel \
	&& dnf clean all
