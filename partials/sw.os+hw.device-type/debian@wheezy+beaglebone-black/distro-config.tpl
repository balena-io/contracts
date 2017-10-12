RUN echo "deb http://debian.beagleboard.org/packages wheezy-bbb main" >> /etc/apt/sources.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key B2710B8359890110
