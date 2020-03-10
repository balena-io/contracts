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

RUN [ ! -d /.balena/messages ] && mkdir -p /.balena/messages; echo $'As of January 1st, 2020, Python 2 was end-of-life, we will change the latest tag for Balenalib Python base image to Python 3.x and drop support for Python 2 soon. So after 1st July, 2020, all the balenalib Python latest tag will point to the latest Python 3 version and no changes, or fixes will be made to balenalib Python 2 base image. If you are using Python 2 for your application, please upgrade to Python 3 before 1st July.' > /.balena/messages/python-deprecation-warning