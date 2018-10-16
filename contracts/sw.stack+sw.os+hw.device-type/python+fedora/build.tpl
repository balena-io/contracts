# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

RUN dnf install -y \
		{{sw.stack.assets.command}}-pip \
		{{sw.stack.assets.command}}-dbus \
	&& dnf clean all

# install "virtualenv", since the vast majority of users of this image will want it
RUN {{sw.stack.assets.pip.command}} install -U --no-cache-dir --ignore-installed pip setuptools \
	&& {{sw.stack.assets.pip.command}} install --no-cache-dir virtualenv
