ENV NODE_VERSION {{sw.stack.version}}
ENV YARN_VERSION {{sw.stack.assets.yarn.version}}

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

RUN for key in \
	6A010C5166006599AA17F08146C2130DFD2497F5 \
	; do \
		gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
		gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" ; \
	done \
	&& curl -SLO "{{sw.stack.assets.bin.url}}" \
	&& echo "{{sw.stack.assets.bin.checksum}}  {{sw.stack.assets.bin.name}}" | sha256sum -c - \
	&& tar -xzf "{{sw.stack.assets.bin.name}}" -C /usr/local --strip-components=1 \
	&& rm "{{sw.stack.assets.bin.name}}" \
	&& curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
	&& curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
	&& gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
	&& mkdir -p /opt/yarn \
	&& tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1 \
	&& ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
	&& ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
	&& rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
	&& npm config set unsafe-perm true -g --unsafe-perm \
	&& rm -rf /tmp/*
