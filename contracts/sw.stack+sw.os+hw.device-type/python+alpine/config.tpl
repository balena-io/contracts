# make some useful symlinks that are expected to exist
RUN cd /usr/local/bin \
	&& ln -sf pip3 pip \
	&& { [ -e easy_install ] || ln -s easy_install-* easy_install; } \
	&& ln -sf idle3 idle \
	&& ln -sf pydoc3 pydoc \
	&& ln -sf python3 python \
	&& ln -sf python3-config python-config
